# https://hub.docker.com/_/caddy
FROM caddy:2.8.4-builder AS builder

RUN xcaddy build \
  --with github.com/caddy-dns/route53 \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/mholt/caddy-ratelimit \
  --with github.com/fvbommel/caddy-dns-ip-range \
  --with github.com/WeidiDeng/caddy-cloudflare-ip \
  --with github.com/xcaddyplugins/caddy-trusted-cloudfront \
  --with github.com/xcaddyplugins/caddy-trusted-gcp-cloudcdn

FROM caddy:2.8.4

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
