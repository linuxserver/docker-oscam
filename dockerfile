FROM alpine:3.20 AS builder

# Build dependencies
RUN apk add --no-cache \
    build-base \
    git \
    openssl-dev \
    pcsc-lite-dev \
    libusb-dev \
    linux-headers \
    curl

# Download OSCam source
WORKDIR /src
RUN git clone https://github.com/oscam/oscam.git .

# Build OSCam with IPv6 support
RUN make USE_IPV6=1

# Runtime image
FROM alpine:3.20

RUN apk add --no-cache \
    openssl \
    pcsc-lite \
    libusb

COPY --from=builder /src/Distribution/oscam /usr/local/bin/oscam

# Create config directory
RUN mkdir -p /config
VOLUME /config

EXPOSE 8888

CMD ["/usr/local/bin/oscam", "-c", "/config"]
