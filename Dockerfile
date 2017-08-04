FROM fedora:26

RUN dnf install -y mock yum yum-utils

ENV USER=markus \
    UID=1000 \
	GROUP=markus \
    GID=1000

RUN groupadd -g "$GID" "$GROUP" \
 && useradd -g "$GROUP" -G mock -u "$UID" "$USER" \
 && echo "config_opts['use_nspawn'] = False" >> /etc/mock/site-defaults.cfg

RUN curl -LsS "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" > /usr/sbin/gosu \
 && chmod +x /usr/sbin/gosu

VOLUME /var/lib/mock
VOLUME /var/cache/mock

COPY entrypoint.sh /entrypoint

ENTRYPOINT [ "/entrypoint" ]
CMD [ "mock" ]
