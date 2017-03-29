FROM alpine:latest

RUN apk --update --no-cache add \
      ca-certificates \
      freetype-dev \
      g++ \
      gcc \
      lvm2 \
      pkgconfig \
      python \
      python-dev \
      py2-libvirt \
      py2-pip \
      openssl && \
    rm -vf /var/cache/apk/* && \
    update-ca-certificates

RUN pip install --no-cache-dir --upgrade pip && \
    find / -name '*.pyc' -or -name '*.pyo' -delete

ADD webvirtmgr /srv/webvirtmgr

RUN pip install --no-cache-dir --upgrade -r /srv/webvirtmgr/requirements.txt && \
    find / -name '*.pyc' -or -name '*.pyo' -delete

EXPOSE 8000

ENTRYPOINT ["/srv/webvirtmgr/manage.py", "runserver", "0.0.0.0:8000"]