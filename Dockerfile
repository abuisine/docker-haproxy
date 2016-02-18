FROM haproxy:1.6
MAINTAINER Alexandre Buisine <alexandrejabuisine@gmail.com>
LABEL version="1.4.2"

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && apt-get install -yqq \
	tcpdump \
	telnet \
 && apt-get -yqq clean \
 && rm -rf /var/lib/apt/lists/*

ADD https://github.com/kreuzwerker/envplate/releases/download/v0.0.8/ep-linux /usr/local/bin/ep
COPY resources/entrypoint.sh /usr/local/sbin/
COPY resources/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
RUN chmod -R +rx /usr/local/bin/ /usr/local/sbin/
ENV ADMIN_PASSWORD="" FRONT_FRONTOFFICE="" FRONT_FRONTOFFICE2="" FRONT_BACKOFFICE="" FRONT_PHPMYADMIN="" BACK_FRONTOFFICE="" BACK_BACKOFFICE="" BACK_PHPMYADMIN="" CERT="" TERM="linux"
RUN mkdir -p /etc/ssl/private && echo '${CERT}' > /etc/ssl/private/cert.pem
EXPOSE 80 443
ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]