FROM node:14.16.0-buster as node
LABEL maintainer="TDSI"
ARG ENVIRONMENT=dev
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build:${ENVIRONMENT}

FROM nginx:1.13-alpine
WORKDIR /usr/src/app
COPY --from=node /usr/src/app/dist/vulnerable-app /usr/share/nginx/html
COPY ./nginx.conf  /etc/nginx/conf.d/default.template
COPY ./cmd.sh  /usr/src/app