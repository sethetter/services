ARG ALPINE_IMAGE_TAG=3.21
ARG GTS_IMAGE_TAG=snapshot

FROM docker.io/alpine:$ALPINE_IMAGE_TAG as builder

ARG LITESTREAM_VERSION=v0.3.13
# Download the static build of Litestream directly into the path & make it executable.
# This is done in the builder and copied as the chmod doubles the size.
ADD https://github.com/benbjohnson/litestream/releases/download/$LITESTREAM_VERSION/litestream-$LITESTREAM_VERSION-linux-amd64.tar.gz /tmp/litestream.tar.gz
RUN tar -C /usr/local/bin -xzf /tmp/litestream.tar.gz

FROM docker.io/superseriousbusiness/gotosocial:$GTS_IMAGE_TAG

# Copy Litestream from builder.
COPY --from=builder /usr/local/bin/litestream /usr/local/bin/litestream

# Copy Litestream configuration file.
COPY litestream.yml /etc/litestream.yml

# Copy and set gotosocial config path
COPY ./config.yaml /gotosocial/config.yaml
ENV GTS_CONFIG_PATH=/gotosocial/config.yaml

# Copy startup script and make it executable.
COPY run.sh /run.sh

# Litestream spawns gotosocials's webserver as subprocess.
CMD ["/run.sh"]
