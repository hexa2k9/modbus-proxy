FROM rockylinux:8-minimal

RUN set -eux \
    && microdnf module enable python39:3.9 \
    && microdnf distro-sync \
    && microdnf install python39 shadow-utils \
    && microdnf clean all

RUN set -eux \
    && pip3 install --no-cache-dir virtualenv \
    && groupadd -r -g 2000 work \
    && adduser -r -M -u 2000 -g work work \
    && mkdir -p /work \
    && chown -R work:work /work

WORKDIR /work

USER work

RUN set -eux \
    && virtualenv .venv \
    && /work/.venv/bin/pip install --no-cache-dir modbus-proxy modbus-proxy[yaml]

EXPOSE 9000

ENTRYPOINT [ "/work/.venv/bin/modbus-proxy" ]
