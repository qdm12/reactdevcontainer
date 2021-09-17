ARG BASEDEV_VERSION=v0.3.0

FROM qmcgaw/basedevcontainer:${BASEDEV_VERSION}-debian
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
# Install Debian packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends nodejs npm yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
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
