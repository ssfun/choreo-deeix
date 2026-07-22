# ==========================================
# DEEIX-Chat 运行镜像 (Choreo Web Application)
# 基于官方镜像，强制非 root + /tmp 可写路径
# ==========================================
FROM ghcr.io/deeix-ai/deeix-chat:v0.3.3

USER root

# 系统层全量安全升级，降低 Trivy CRITICAL 失败率
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends ca-certificates tzdata \
    && rm -rf /var/lib/apt/lists/*

# 官方镜像声明 VOLUME /app/data /app/storage；Choreo 容器文件系统只读，
# 将业务可写路径统一导向 /tmp（业务状态仍应落在 Postgres + R2）
RUN rm -rf /app/data /app/storage \
    && ln -s /tmp/deeix-data /app/data \
    && ln -s /tmp/deeix-storage /app/storage

COPY --from=ghcr.io/komari-monitor/komari-agent:latest /app/komari-agent /app/komari-agent
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh /app/komari-agent \
    && chown -R 10014:10014 /app

# --- Choreo 默认运行时约定（均可被环境变量覆盖）---
ENV TZ=Asia/Shanghai \
    APP_ENV=prod \
    HTTP_PORT=8080 \
    FRONTEND_DIST_DIR=/app/frontend/out \
    HOME=/tmp \
    DATABASE_DRIVER=postgres \
    CACHE_DRIVER=memory \
    STORAGE_BACKEND=s3 \
    STORAGE_ROOT_DIR=/tmp/deeix-storage \
    STORAGE_S3_REGION=auto \
    STORAGE_S3_FORCE_PATH_STYLE=true \
    SQLITE_PATH=/tmp/deeix-data/deeix.db

WORKDIR /app

# Choreo 要求 numeric USER 10000-20000
USER 10014

EXPOSE 8080

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/app/deeix-chat"]
