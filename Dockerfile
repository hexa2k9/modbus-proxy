FROM python:3.13.3-alpine3.20 AS builder

RUN set -eux \
    && pip3 install --no-cache-dir virtualenv

ADD requirements.txt /

RUN set -eux \
    && virtualenv /opt/virtualenv \
    && /opt/virtualenv/bin/pip install --no-cache-dir -r /requirements.txt

FROM python:3.13.3-alpine3.20

RUN set -eux \
    && apk --no-cache upgrade

COPY --from=builder /opt/virtualenv /opt/virtualenv

EXPOSE 9000

ENTRYPOINT [ "/opt/virtualenv/bin/modbus-proxy" ]
