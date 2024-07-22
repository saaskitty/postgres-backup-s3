ARG POSTGRES_VERSION
ARG TARGETARCH
FROM postgres:${POSTGRES_VERSION}-alpine

ADD src/install.sh install.sh
RUN sh install.sh && rm install.sh

ENV POSTGRES_DB ''
ENV POSTGRES_DB_URL ''
ENV PGDUMP_EXTRA_OPTS ''
ENV S3_ACCESS_KEY_ID ''
ENV S3_SECRET_ACCESS_KEY ''
ENV S3_BUCKET ''
ENV S3_REGION 'auto'
ENV S3_PATH 'backup'
ENV S3_ENDPOINT ''
ENV S3_S3V4 'no'
ENV SCHEDULE ''
ENV PASSPHRASE ''
ENV BACKUP_KEEP_DAYS ''

ADD src/run.sh run.sh
ADD src/env.sh env.sh
ADD src/backup.sh backup.sh
ADD src/restore.sh restore.sh

CMD ["sh", "run.sh"]
