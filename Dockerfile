ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}
ARG TARGETARCH

ADD src/install.sh install.sh
RUN sh install.sh && rm install.sh

ENV PRIMARY_DB ''
ENV PRIMARY_DB_URL ''
ENV PGDUMP_EXTRA_OPTS ''
ENV AWS_S3_ACCESS_KEY_ID ''
ENV AWS_S3_SECRET_ACCESS_KEY ''
ENV AWS_S3_BUCKET ''
ENV AWS_S3_REGION 'auto'
ENV AWS_S3_PATH 'backup'
ENV AWS_S3_ENDPOINT ''
ENV AWS_S3_S3V4 'no'
ENV SCHEDULE ''
ENV PASSPHRASE ''
ENV BACKUP_KEEP_DAYS ''

ADD src/run.sh run.sh
ADD src/env.sh env.sh
ADD src/backup.sh backup.sh
ADD src/restore.sh restore.sh

CMD ["sh", "run.sh"]
