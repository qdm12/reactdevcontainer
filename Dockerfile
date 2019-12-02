ARG ALPINE_VERSION=3.10
ARG NODE_VERSION=13.2
ARG DOCKER_VERSION=19.03.4
ARG DOCKER_COMPOSE_VERSION=1.25.0-rc4-alpine

FROM docker:${DOCKER_VERSION} AS docker-cli
FROM docker/compose:${DOCKER_COMPOSE_VERSION} AS docker-compose

FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION}
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=local
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000
LABEL \
    org.opencontainers.image.authors="quentin.mcgaw@gmail.com" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.url="https://github.com/qdm12/reactdevcontainer" \
    org.opencontainers.image.documentation="https://github.com/qdm12/reactdevcontainer" \
    org.opencontainers.image.source="https://github.com/qdm12/reactdevcontainer" \
    org.opencontainers.image.title="React Dev container" \
    org.opencontainers.image.description="ReactJS development container for Visual Studio Code Remote Containers development"
WORKDIR /home/${USERNAME}
ENTRYPOINT [ "/bin/zsh" ]

# Setup user
RUN deluser "$(getent passwd $USER_UID | cut -d: -f1)"
RUN adduser $USERNAME -s /bin/sh -D -u $USER_UID $USER_GID && \
    mkdir -p /etc/sudoers.d && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# Install Alpine packages
RUN apk add -q --update --progress libstdc++ zsh sudo ca-certificates git openssh-client bash nano

COPY --from=docker-cli --chown=${USER_UID}:${USER_GID} /usr/local/bin/docker /usr/local/bin/docker
COPY --from=docker-compose --chown=${USER_UID}:${USER_GID} /usr/local/bin/docker-compose /usr/local/bin/docker-compose
ENV DOCKER_BUILDKIT=1
# All possible docker host groups
RUN ([ ${USER_GID} = 1000 ] || (addgroup -g 1000 docker1000 && addgroup ${USERNAME} docker1000)) && \
    addgroup -g 976 docker976 && \
    addgroup -g 102 docker102 && \
    addgroup ${USERNAME} docker976 && \
    addgroup ${USERNAME} docker102

# Setup shells
ENV EDITOR=nano \
    LANG=en_US.UTF-8
RUN apk add shadow && \
    usermod --shell /bin/zsh root && \
    usermod --shell /bin/zsh ${USERNAME} && \
    apk del shadow
COPY --chown=${USER_UID}:${USER_GID} shell/.p10k.zsh shell/.zshrc shell/.welcome.sh /home/${USERNAME}/
RUN ln -s /home/${USERNAME}/.p10k.zsh /root/.p10k.zsh && \
    cp /home/${USERNAME}/.zshrc /root/.zshrc && \
    cp /home/${USERNAME}/.welcome.sh /root/.welcome.sh && \
    sed -i "s/HOMEPATH/home\/${USERNAME}/" /home/${USERNAME}/.zshrc && \
    sed -i "s/HOMEPATH/root/" /root/.zshrc
RUN git clone --single-branch --depth 1 https://github.com/robbyrussell/oh-my-zsh.git /home/${USERNAME}/.oh-my-zsh &> /dev/null && \
    rm -rf /home/${USERNAME}/.oh-my-zsh/.git && \
    git clone --single-branch --depth 1 https://github.com/romkatv/powerlevel10k.git /home/${USERNAME}/.oh-my-zsh/custom/themes/powerlevel10k &> /dev/null && \
    rm -rf /home/${USERNAME}/.oh-my-zsh/custom/themes/powerlevel10k/.git && \
    chown -R ${USERNAME}:${USER_GID} /home/${USERNAME}/.oh-my-zsh && \
    chmod -R 700 /home/${USERNAME}/.oh-my-zsh && \
    cp -r /home/${USERNAME}/.oh-my-zsh /root/.oh-my-zsh && \
    chown -R root:root /root/.oh-my-zsh

# Sets directories for NPM global packages
ENV NODE_PATH="/home/${USERNAME}/.npm-packages/lib/node_modules" \
    MANPATH="/home/${USERNAME}/.npm-packages/share/man"
RUN mkdir "/home/${USERNAME}/.npm-packages" && \
    echo "prefix = /home/${USERNAME}/.npm-packages" >> /home/${USERNAME}/.npmrc && \
    export PATH="/home/${USERNAME}/.npm-packages/bin:$PATH"
# Install some global NPM packages
RUN npm install -g create-react-app mocha react-native-cli

USER ${USERNAME}
