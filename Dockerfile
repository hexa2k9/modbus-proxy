FROM python:3.13-alpine3.20

RUN set -eux \
    && pip3 install --no-cache-dir virtualenv

RUN set -eux \
    && virtualenv /opt/virtualenv \
    && /opt/virtualenv/bin/pip install --no-cache-dir modbus-proxy modbus-proxy[yaml]

EXPOSE 9000

ENTRYPOINT [ "/opt/virtualenv/bin/modbus-proxy" ]
