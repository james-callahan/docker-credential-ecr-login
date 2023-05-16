FROM --platform=$BUILDPLATFORM busybox:stable AS download

ARG TARGETOS
ARG TARGETARCH
ARG VERSION="0.7.0"

ARG CHECKSUM
RUN CHECKSUM="${CHECKSUM:-$(case "${VERSION}/${TARGETOS}-${TARGETARCH}" in \
      0.7.0/linux-amd64) echo c978912da7f54eb3bccf4a3f990c91cc758e1494a8af7a60f3faf77271b565db;; \
      0.7.0/linux-arm64) echo ff14a4da40d28a2d2d81a12a7c9c36294ddf8e6439780c4ccbc96622991f3714;; \
      *) echo "Unknown checksum"; exit 1;; \
    esac)}" \
  && wget https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/${VERSION}/${TARGETOS}-${TARGETARCH}/docker-credential-ecr-login \
  && (echo "${CHECKSUM}  docker-credential-ecr-login" | sha256sum -c) \
  && chmod +x docker-credential-ecr-login

FROM scratch
LABEL org.opencontainers.image.source=https://github.com/awslabs/amazon-ecr-credential-helper/
COPY --from=download docker-credential-ecr-login /usr/local/bin/docker-credential-ecr-login
ENTRYPOINT ["/usr/local/bin/docker-credential-ecr-login"]
