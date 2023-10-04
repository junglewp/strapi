# BASE
ARG NODE_VERSION=18
FROM node:${NODE_VERSION}-alpine AS base-alpine
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev git > /dev/null 2>&1
EXPOSE 1337

FROM base-alpine
RUN yarn global add node-gyp
ARG STRAPI_VERSION=latest
RUN yarn global add @strapi/strapi@${STRAPI_VERSION}


RUN mkdir -p /srv/app && chown 1000:1000 -R /srv/app

WORKDIR /srv/app

VOLUME /srv/app

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod 777 /usr/local/bin/docker-entrypoint.sh && ln -s /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["strapi"]
