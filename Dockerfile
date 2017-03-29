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
      py-libxml2 \
      py2-pip \
      openssl \
      uwsgi-python && \
    rm -vf /var/cache/apk/* && \
    update-ca-certificates

RUN pip install --no-cache-dir --upgrade pip && \
    find / -name '*.pyc' -or -name '*.pyo' -delete

ADD webvirtmgr /srv/webvirtmgr

RUN pip install --no-cache-dir --upgrade -r /srv/webvirtmgr/requirements.txt && \
    find / -name '*.pyc' -or -name '*.pyo' -delete

ADD uwsgi.yaml /srv/uwsgi.yaml

EXPOSE 8000

ENTRYPOINT ["/usr/sbin/uwsgi", "-y", "/srv/uwsgi.yaml"]
