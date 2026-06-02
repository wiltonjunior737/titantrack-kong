FROM kong:latest

COPY kong.yml /usr/local/kong/kong.yml

ENV KONG_DATABASE=off
ENV KONG_DECLARATIVE_CONFIG=/usr/local/kong/kong.yml
ENV KONG_PROXY_LISTEN="0.0.0.0:8000, 0.0.0.0:8443 ssl"

EXPOSE 8000 8443