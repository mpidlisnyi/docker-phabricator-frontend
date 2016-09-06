FROM nginx:1.11
MAINTAINER mpodlesnyi@smartling.com

RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y ruby git openssl && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    PHABRICATOR_COMMIT=be84c05

RUN mkdir -p /srv/phabricator
WORKDIR /tmp
RUN git clone --branch stable https://github.com/phacility/phabricator.git phabricator \
 && cd phabricator && git checkout $PHABRICATOR_COMMIT -b prod && cd .. \
 && mv phabricator/webroot /srv/phabricator/ \
 && rm -rf phabricator

WORKDIR /srv/phabricator

COPY nginx.conf.erb /nginx.conf.erb
COPY openssl.cnf /openssl_for_selfsigned_cert.cnf

COPY nginx-entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

EXPOSE 80 443

ENTRYPOINT [ "/entrypoint" ]

CMD ["nginx"]

