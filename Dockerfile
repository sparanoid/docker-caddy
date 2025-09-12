# https://hub.docker.com/_/caddy
FROM caddy:2.10.2-builder AS builder

# https://github.com/caddy-dns/route53/issues/58
RUN git clone https://github.com/theAeon/route53.git

RUN xcaddy build \
  --with github.com/caddyserver/cache-handler \
  --with github.com/caddy-dns/route53 --replace github.com/libdns/route53@v1.5.1=./route53 \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/caddy-dns/cloudns \
  --with github.com/mholt/caddy-ratelimit \
  --with github.com/fvbommel/caddy-dns-ip-range \
  --with github.com/WeidiDeng/caddy-cloudflare-ip \
  --with github.com/xcaddyplugins/caddy-trusted-cloudfront \
  --with github.com/xcaddyplugins/caddy-trusted-gcp-cloudcdn

FROM caddy:2.10.2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
