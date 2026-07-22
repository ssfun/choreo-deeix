# DEEIX-Chat - Choreo 部署说明

基于 [DEEIX-AI/DEEIX-Chat](https://github.com/DEEIX-AI/DEEIX-Chat) 官方镜像的 **Choreo Web Application** 适配层。

- 组件类型：**Web Application**（Dockerfile）
- 单公网端口 `8080`
- `USER 10014`
- 可写路径仅 `/tmp`
- 业务库：**Postgres**（`POSTGRES_DSN`）
- 对象存储：**Cloudflare R2**（`STORAGE_BACKEND=s3`）
- 可选内嵌 **komari-agent**

上游当前锁定版本见 [README.md](./README.md)（`# Version`）。

---

## 架构

```text
浏览器
  └─ https://deeix.example.com  （或 *.choreoapps.dev）
        └─ Choreo Web Application :8080
              ├─ /app/deeix-chat   （Go API + 静态前端）
              ├─ /tmp/*            （临时本地路径；业务不依赖持久盘）
              ├─ Postgres          （POSTGRES_DSN）
              ├─ R2 / S3           （STORAGE_S3_*）
              └─ (可选) komari-agent → 你的 Komari 面板
```

不需要：

- Service 组件 / REST+WS 双 endpoint
- Caddy 第二端口
- Cloudflare Snippet 的 WebSocket 路径注入

---

## 仓库结构

```text
choreo-deeix/
├── Dockerfile
├── entrypoint.sh
├── .trivyignore
├── .github/workflows/update-version.yml
├── README.md
└── README.choreo.md
```

---

## 1. 创建 Choreo Web Application

| 项 | 值 |
|---|---|
| Component type | **Web Application** |
| Build preset | **Dockerfile** |
| Dockerfile Path | `/Dockerfile` |
| Component Directory | `/` |
| Port | **`8080`** |

连接本仓库后 Build → Deploy。

文档：

- [Deploy a containerized application](https://wso2.com/engineering-platform/developer-platform/docs/develop-components/deploy-a-containerized-application/)
- [Build and deploy a web application](https://wso2.com/engineering-platform/developer-platform/docs/develop-components/develop-web-applications/build-and-deploy-a-single-page-web-application/)

---

## 2. 环境变量

优先级：环境变量 > `config.yaml` > 默认值（官方行为）。本镜像**不**烘焙 `config.yaml`，全部用 Choreo Configs / Secrets 注入。

### 2.1 必配（生产）

| 变量 | 示例 / 说明 | 类型 |
|---|---|---|
| `APP_ENV` | `prod` | Config |
| `HTTP_PORT` | `8080` | Config |
| `PUBLIC_API_BASE_URL` | `https://deeix.example.com` | Config |
| `PUBLIC_WEB_BASE_URL` | 与 API 相同（单 runtime 同源） | Config |
| `CORS_ALLOW_ORIGIN` | `https://deeix.example.com`（勿 `*`） | Config |
| `JWT_SECRET` | ≥16 随机串 | **Secret** |
| `DATA_ENCRYPTION_KEY` | ≥32 随机串，**上线后勿随意轮换** | **Secret** |
| `DATABASE_DRIVER` | `postgres` | Config |
| `POSTGRES_DSN` | 见下 | **Secret** |

生成密钥示例：

```bash
openssl rand -base64 32   # JWT_SECRET
openssl rand -base64 48   # DATA_ENCRYPTION_KEY
```

### 2.2 Postgres（`POSTGRES_DSN`）

```text
postgres://USER:PASSWORD@HOST:5432/DBNAME?sslmode=require&TimeZone=Asia/Shanghai
```

| 来源 | 说明 |
|---|---|
| Choreo Managed PostgreSQL | 控制台创建后拷贝连接串；注意 SSL 参数 |
| 外部托管（Neon / Supabase / 自建） | 同样只注入 `POSTGRES_DSN` |

本地开发示例里的 `sslmode=disable` **不要**用于公网。

可选调优：

| 变量 | 默认（官方） |
|---|---|
| `POSTGRES_MAX_OPEN_CONNS` | `30` |
| `POSTGRES_MAX_IDLE_CONNS` | `10` |
| `POSTGRES_CONN_MAX_LIFETIME_MINUTES` | `60` |
| `POSTGRES_CONN_MAX_IDLE_TIME_MINUTES` | `10` |

### 2.3 R2 对象存储（`STORAGE_BACKEND=s3`）

镜像默认 `STORAGE_BACKEND=s3`、`STORAGE_S3_REGION=auto`、`STORAGE_S3_FORCE_PATH_STYLE=true`。

| 变量 | 说明 |
|---|---|
| `STORAGE_BACKEND` | 固定 `s3` |
| `STORAGE_S3_ENDPOINT` | `https://<ACCOUNT_ID>.r2.cloudflarestorage.com` |
| `STORAGE_S3_REGION` | `auto`（R2 常用） |
| `STORAGE_S3_BUCKET` | Bucket 名 |
| `STORAGE_S3_PREFIX` | 可选前缀，如 `deeix/` |
| `STORAGE_S3_ACCESS_KEY_ID` | R2 API Token Access Key | **Secret** |
| `STORAGE_S3_SECRET_ACCESS_KEY` | R2 API Token Secret | **Secret** |
| `STORAGE_S3_FORCE_PATH_STYLE` | `true`（R2 推荐） |
| `STORAGE_ROOT_DIR` | 仍指向 `/tmp/deeix-storage`（s3 模式下仅作本地临时） |

Cloudflare R2 控制台：R2 → Manage R2 API Tokens → 创建具备该 bucket 读写权限的 token。

### 2.4 缓存（可选）

| 场景 | 配置 |
|---|---|
| 单副本试用 | `CACHE_DRIVER=memory`（镜像默认） |
| 多用户 / 以后扩容 | `CACHE_DRIVER=redis` + 下表 |

| 变量 | 说明 |
|---|---|
| `CACHE_DRIVER` | `redis` / `memory` |
| `REDIS_ADDR` | `host:6379` |
| `REDIS_PASSWORD` | 可选 | **Secret** |
| `REDIS_USERNAME` | 可选 |
| `REDIS_DB` | 默认 `0` |
| `REDIS_TLS_ENABLED` | `true` / `false` |
| `REDIS_TLS_INSECURE_SKIP_VERIFY` | 慎用 |

### 2.5 Komari Agent（可选）

与 openwebui / lobehub 相同：

| 变量 | 说明 |
|---|---|
| `KOMARI_SERVER` | Agent 入口，如 `https://komari.example.com/default/komari/komari_ws/v1.0`（按你面板实际） |
| `KOMARI_SECRET` | Agent token | **Secret** |

二者都非空时 entrypoint 后台启动 `/app/komari-agent`。

### 2.6 其它常用

| 变量 | 说明 |
|---|---|
| `TRUSTED_PROXIES` | 回源代理 CIDR；经 CF/Choreo 时按实际填写 |
| `SSRF_PROTECTION_ENABLED` | 公网建议评估后开启 |
| `CONFIG_FILE` | 一般不需要；若挂文件型配置再用 |

---

## 3. 部署步骤

1. 准备 **Postgres** 库与用户，拿到 `POSTGRES_DSN`。
2. 准备 **R2** bucket + API Token。
3. 推送本仓库到 GitHub，在 Choreo 创建 **Web Application**（见第 1 节）。
4. 在 Deploy / DevOps 页配置 Configs & Secrets（第 2 节）。
5. **Build Latest** → Deploy。
6. 打开组件 URL，确认健康（路径以官方为准，常见为 `/healthz`）。
7. 查看运行日志：首次启动若无超管，会**一次性**打印 admin 初始密码 → 登录后立即改密。
8. 将 `PUBLIC_API_BASE_URL` / `PUBLIC_WEB_BASE_URL` / `CORS_ALLOW_ORIGIN` 改成最终公网地址后重新部署配置。
9. （可选）绑定自定义域名；Cloudflare 橙云、SSL 回源按你现有习惯（`*.choreoapps.dev` / 数据平面域名常用 Full）。

---

## 4. 最小 Secret 清单（复制用）

```bash
# 应用
APP_ENV=prod
HTTP_PORT=8080
PUBLIC_API_BASE_URL=https://deeix.example.com
PUBLIC_WEB_BASE_URL=https://deeix.example.com
CORS_ALLOW_ORIGIN=https://deeix.example.com
JWT_SECRET=...
DATA_ENCRYPTION_KEY=...

# Postgres
DATABASE_DRIVER=postgres
POSTGRES_DSN=postgres://user:pass@host:5432/deeix?sslmode=require&TimeZone=Asia/Shanghai

# R2
STORAGE_BACKEND=s3
STORAGE_S3_ENDPOINT=https://<ACCOUNT_ID>.r2.cloudflarestorage.com
STORAGE_S3_REGION=auto
STORAGE_S3_BUCKET=deeix
STORAGE_S3_PREFIX=deeix/
STORAGE_S3_ACCESS_KEY_ID=...
STORAGE_S3_SECRET_ACCESS_KEY=...
STORAGE_S3_FORCE_PATH_STYLE=true

# 可选
# CACHE_DRIVER=redis
# REDIS_ADDR=...
# REDIS_PASSWORD=...
# KOMARI_SERVER=...
# KOMARI_SECRET=...
```

---

## 5. 验证

```bash
# 健康检查（域名换成你的 Web App URL）
curl -sS "https://deeix.example.com/healthz"

# 首页应返回 HTML
curl -sS -o /dev/null -w "%{http_code}\n" "https://deeix.example.com/"

# 登录后：发起一轮流式对话、上传一个小文件（确认 R2）
```

浏览器：

1. 首次登录 `admin` + 日志中的密码 → 强制改密  
2. 管理后台配置模型上游  
3. 上传文件后在 R2 bucket / 前缀下应能看到对象  

---

## 6. 镜像与构建说明

| 项 | 说明 |
|---|---|
| 上游镜像 | `ghcr.io/deeix-ai/deeix-chat:v0.3.3`（与 README Version 同步） |
| 二进制 | `/app/deeix-chat` |
| 前端静态资源 | `/app/frontend/out`（`FRONTEND_DIST_DIR`） |
| 用户 | `10014`（Choreo 强制 10000–20000） |
| Komari Agent | 构建时从 `komari-monitor/komari-agent` 最新 tag 编译 |
| 可写 | `/tmp/deeix-data`、`/tmp/deeix-storage`；`/app/data`、`/app/storage` 软链到此 |

Trivy **CRITICAL** 会导致 Choreo 构建失败：

1. 先依赖 Dockerfile 内 `apt-get upgrade`  
2. 定期重建镜像吃安全补丁  
3. 短期无法修复时把 CVE 写入 `.trivyignore`（每行一个）

---

## 7. 限制与注意

| 点 | 说明 |
|---|---|
| Web Application 单端口 | 本应用单进程 8080，符合 |
| 无公网 WebSocket | DEEIX 聊天流式不依赖浏览器 WS endpoint |
| 请求体约 256KB（云数据平面文档） | 超大直传可能失败；优先 R2 / 预签名策略；小文件一般 OK |
| `/tmp` 非持久 | DB 在 Postgres、文件在 R2；不要依赖容器本地状态 |
| `DATA_ENCRYPTION_KEY` | 轮换前需有再加密方案，视同准永久密钥 |
| 首次 admin 密码 | 只在日志出现一次，勿写进配置 |
| Scale-to-zero | 冷启动可接受则可开；会话状态在 Postgres，文件在 R2 |

---

## 8. 故障速查

| 现象 | 处理 |
|---|---|
| 构建 USER 校验失败 | 确认 Dockerfile 末尾 `USER 10014` |
| Trivy CRITICAL | 升级基础包 / 换更新上游 tag / `.trivyignore` |
| 启动报 DB | 检查 `DATABASE_DRIVER=postgres` 与 `POSTGRES_DSN`（含 SSL） |
| 上传失败 | 检查 R2 endpoint/bucket/密钥/`FORCE_PATH_STYLE`；或是否触发请求体上限 |
| 登录/跨域异常 | `PUBLIC_*` 与 `CORS_ALLOW_ORIGIN` 必须与浏览器 Origin 一致且 HTTPS |
| 页面空白但 API 正常 | 确认 `FRONTEND_DIST_DIR=/app/frontend/out` 未被覆盖 |
| Komari 无数据 | `KOMARI_SERVER` / `KOMARI_SECRET` 是否都设置；agent 日志是否被丢弃（默认重定向到 `/dev/null`） |
| prod 拒绝启动 | `JWT_SECRET` / `DATA_ENCRYPTION_KEY` 长度与默认值校验 |

---

## 9. 与同目录其它项目对照

| | openwebui | lobehub | **deeix** |
|---|---|---|---|
| 类型 | Web Application | Web Application | Web Application |
| 端口 | 8080 | 3210 | **8080** |
| DB | 多为内置/外置 | `DATABASE_URL` 等 | **`POSTGRES_DSN`** |
| 存储 | 本地 `/tmp` 为主 | 应用自管 | **R2 (`STORAGE_S3_*`)** |
| Komari | 有 | 有 | **有** |
| WS 拆分 | 关 WS | 无 | **无** |

---

## 10. 上游与版本同步

- 上游仓库：https://github.com/DEEIX-AI/DEEIX-Chat  
- 配置文档：https://deeix.com/docs/deeix-chat/configuration  
- 快速开始：https://deeix.com/docs/deeix-chat/quickstart  
- 本仓库 `update-version.yml`：每日检查最新 release，更新 `README.md` Version/Releases 与 Dockerfile 镜像 tag（可选 Telegram 通知：`TELEGRAM_TOKEN` / `TELEGRAM_TO`）

手动 bump 时改两处：

1. `Dockerfile`：`FROM ghcr.io/deeix-ai/deeix-chat:<tag>`  
2. `README.md`：`# Version` 与 `# Releases`
