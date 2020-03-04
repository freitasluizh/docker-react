from node:alpine as builder

WORKDIR '/app'

COPY package.json .

ENV HTTPS_PROXY "http://127.0.0.1:3128"
ENV HTTP_PROXY "http://127.0.0.1:3128"

RUN npm config set http-proxy http://docker.for.win.localhost:3128
run npm config set https-proxy http://docker.for.win.localhost:3128

RUN npm install

COPY . .

RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html