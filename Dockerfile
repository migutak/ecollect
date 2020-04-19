FROM node:12.6.0-alpine AS builder
USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node package.json ./
RUN npm install
COPY --chown=node . .
RUN $(npm bin)/ng build --prod

FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /home/node/app/dist/ecollect /usr/share/nginx/html
