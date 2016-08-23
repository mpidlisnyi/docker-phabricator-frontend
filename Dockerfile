FROM nginx:1.11
MAINTAINER mpodlesnyi@smartling.com

RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y ruby git && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/phabricator
WORKDIR /var/www/phabricator
RUN git clone https://github.com/phacility/phabricator.git

COPY nginx.conf.erb /nginx.conf.erb

COPY nginx-entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

EXPOSE 80 443

ENTRYPOINT [ "/entrypoint" ]

CMD ["nginx"]

