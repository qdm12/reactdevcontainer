# React Dev Container

Ultimate React development container for Visual Studio Code

[![CI build](https://github.com/qdm12/reactdevcontainer/actions/workflows/ci.yml/badge.svg)](https://github.com/qdm12/reactdevcontainer/actions/workflows/ci.yml)

[![dockeri.co](https://dockeri.co/image/qmcgaw/reactdevcontainer)](https://hub.docker.com/r/qmcgaw/reactdevcontainer)

![Last Docker tag](https://img.shields.io/docker/v/qmcgaw/reactdevcontainer?sort=semver&label=Last%20Docker%20tag)
[![Latest size](https://img.shields.io/docker/image-size/qmcgaw/reactdevcontainer/latest?label=Latest%20image)](https://hub.docker.com/r/qmcgaw/reactdevcontainer/tags)

![Last release](https://img.shields.io/github/release/qdm12/reactdevcontainer?label=Last%20release)
[![Last release size](https://img.shields.io/docker/image-size/qmcgaw/reactdevcontainer?sort=semver&label=Last%20released%20image)](https://hub.docker.com/r/qmcgaw/reactdevcontainer/tags?page=1&ordering=last_updated)
![GitHub last release date](https://img.shields.io/github/release-date/qdm12/reactdevcontainer?label=Last%20release%20date)
![Commits since release](https://img.shields.io/github/commits-since/qdm12/reactdevcontainer/latest?sort=semver)

[![GitHub last commit](https://img.shields.io/github/last-commit/qdm12/reactdevcontainer.svg)](https://github.com/qdm12/reactdevcontainer/commits/main)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/y/qdm12/reactdevcontainer.svg)](https://github.com/qdm12/reactdevcontainer/graphs/contributors)
[![GitHub closed PRs](https://img.shields.io/github/issues-pr-closed/qdm12/reactdevcontainer.svg)](https://github.com/qdm12/reactdevcontainer/pulls?q=is%3Apr+is%3Aclosed)
[![GitHub issues](https://img.shields.io/github/issues/qdm12/reactdevcontainer.svg)](https://github.com/qdm12/reactdevcontainer/issues)
[![GitHub closed issues](https://img.shields.io/github/issues-closed/qdm12/reactdevcontainer.svg)](https://github.com/qdm12/reactdevcontainer/issues?q=is%3Aissue+is%3Aclosed)

![Visitors count](https://visitor-badge.laobi.icu/badge?page_id=reactdevcontainer.readme)

## Features

- Based on [qmcgaw/basedevcontainer](https://github.com/qdm12/basedevcontainer)
  - Minimal custom terminal and packages
  - Nodejs, npm and yarn downloaded as Alpine packages
  - See more [features](https://github.com/qdm12/basedevcontainer#features)
- Globally installed: `nodemon`, `create-react-app`, `mocha`, and `jest`
- Cross platform
  - Easily bind mount your SSH keys to use with **git**
  - Manage your host Docker from within the dev container, more details at [qmcgaw/basedevcontainer](https://github.com/qdm12/basedevcontainer#features)
- Extensible with docker-compose.yml
- Two versions:
  1. **Alpine 3.14** based
      - Image tags  `:latest`, `:alpine` and `:alpine-vx.x.x`
      - Size of 259MB
      - ⚠️ does not work on `arm64` due to [vscode-remote-release#4462](https://github.com/microsoft/vscode-remote-release/issues/4462)
  2. **Debian Buster Slim** based
      - Image tags `:debian` and `:debian-vx.x.x`
      - Size of 466MB
- Compatible with `amd64`, `arm64`, `armv7`, `armv6`, `s390x` and `ppc64le`

## Requirements

- [Docker](https://www.docker.com/products/docker-desktop) installed and running
  - If you don't use Linux, share the directories `~/.ssh` and the directory of your project with Docker Desktop
- [Docker Compose](https://docs.docker.com/compose/install/) installed
- [VS code](https://code.visualstudio.com/download) installed
- [VS code remote containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed

## Setup for a project

1. Setup your configuration files
    - With style 💯

        ```sh
        docker run -it --rm -v "/yourrepopath:/repository" qmcgaw/devtainr:v0.2.0 -dev react -path /repository -name projectname
        ```

        Or use the [built binary](https://github.com/qdm12/devtainr#binary)
    - Or manually: download this repository and put the [.devcontainer](.devcontainer) directory in your project.
1. If you have a *.vscode/settings.json*, eventually move the settings to *.devcontainer/devcontainer.json* in the `"settings"` section as *.vscode/settings.json* take precedence over the settings defined in *.devcontainer/devcontainer.json*.
1. Open the command palette in Visual Studio Code (CTRL+SHIFT+P) and select `Remote-Containers: Open Folder in Container...` and choose your project directory
1. If you want to use the Debian based image, you can modify the .devcontainer/Dockerfile in your directory.

**Note that by default it will map the port `3000` to a random port on your host, which you can find with `docker ps`**

## Customization

See the [.devcontainer/README.md](.devcontainer/README.md) document in your repository.

## TODOs

- [qmcgaw/basedevcontainer](https://github.com/qdm12/basedevcontainer) todos

## License

This repository is under an [MIT license](https://github.com/qdm12/reactdevcontainer/master/LICENSE) unless indicated otherwise.
