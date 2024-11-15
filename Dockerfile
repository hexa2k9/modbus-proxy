FROM python:3.13-alpine3.20

RUN set -eux \
    && apk --no-cache upgrade

RUN set -eux \
    && pip3 install --no-cache-dir virtualenv

ADD requirements.txt /

RUN set -eux \
    && virtualenv /opt/virtualenv \
    && /opt/virtualenv/bin/pip install --no-cache-dir -r /requirements.txt

EXPOSE 9000

ENTRYPOINT [ "/opt/virtualenv/bin/modbus-proxy" ]
