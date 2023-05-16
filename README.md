Building/pushing:

```shell
# Need to reset for new build
buildah manifest rm ghcr.io/james-callahan/docker-credential-ecr-login:latest
buildah bud \
  --platform linux/arm64,linux/amd64 \
  --timestamp="$(stat -c %Y Dockerfile)" \
  --label=org.opencontainers.image.version=0.7.0 \
  --manifest ghcr.io/james-callahan/docker-credential-ecr-login:latest \
  .
buildah manifest push \
  --all \
  ghcr.io/james-callahan/docker-credential-ecr-login:latest \
  docker://ghcr.io/james-callahan/docker-credential-ecr-login:latest
buildah manifest push \
  --all \
  ghcr.io/james-callahan/docker-credential-ecr-login:latest \
  docker://ghcr.io/james-callahan/docker-credential-ecr-login:v0.7.0
```
