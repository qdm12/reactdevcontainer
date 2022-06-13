ARG BASEDEV_VERSION=v0.13.0

FROM qmcgaw/basedevcontainer:${BASEDEV_VERSION}-alpine
ARG CREATED
ARG COMMIT
ARG VERSION=local
LABEL \
    org.opencontainers.image.authors="quentin.mcgaw@gmail.com" \
    org.opencontainers.image.created=$CREATED \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.revision=$COMMIT \
    org.opencontainers.image.url="https://github.com/qdm12/reactdevcontainer" \
    org.opencontainers.image.documentation="https://github.com/qdm12/reactdevcontainer" \
    org.opencontainers.image.source="https://github.com/qdm12/reactdevcontainer" \
    org.opencontainers.image.title="React Dev container Alpine" \
    org.opencontainers.image.description="React TS development container for Visual Studio Code Remote Containers development"
# Install Alpine packages
RUN apk add -q --update --progress --no-cache nodejs npm yarn
# Setup shells
COPY shell/.zshrc-specific shell/.welcome.sh /root/
# Sets directories for NPM global packages
ENV NODE_PATH="/root/.npm-packages/lib/node_modules" \
    MANPATH="/root/.npm-packages/share/man"
RUN echo "prefix = /root/.npm-packages" >> /root/.npmrc && \
    chmod 600 /root/.npmrc
ENV PATH=/root/.npm-packages/bin:$PATH
# Fix ownership and permissions of anonymous volume 'node_modules'
VOLUME [ "/workspace/node_modules" ]
RUN mkdir -p /workspace/node_modules && \
    chmod 700 /workspace/node_modules
