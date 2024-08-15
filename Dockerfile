FROM docker.io/dunglas/frankenphp:latest
ENV CADDY_GLOBAL_OPTIONS="admin off"

HEALTHCHECK --start-period=15s --retries=2 --interval=60s CMD curl --fail $SERVER_NAME || exit 1

COPY taskscheduler /taskscheduler
RUN apt update && \
    apt full-upgrade -y -qq && \
    apt install cron -y -qq && \
    crontab /taskscheduler

RUN install-php-extensions \
    pdo_mysql \
    mysqli \
    gettext

COPY init.sh /init.sh
WORKDIR /app
COPY domainmod ./public

ENV FRANKENPHP_DOCUMENT_ROOT=/app/public

CMD ["/init.sh"]