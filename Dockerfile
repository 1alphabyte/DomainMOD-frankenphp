FROM docker.io/dunglas/frankenphp:latest
ENV CADDY_GLOBAL_OPTIONS="admin off"

HEALTHCHECK --start-period=15s --retries=2 --interval=60s CMD curl --fail $SERVER_NAME || exit 1

RUN install-php-extensions \
    pdo \
    pdo_mysql \
    mysqli \
    curl \
    openssl \
    gettext

COPY ./domainmod /app