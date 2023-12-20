# React Dev Container

Ultimate React development container for Visual Studio Code

[![CI build](https://github.com/kbuley/reactdevcontainer/actions/workflows/ci.yml/badge.svg)](https://github.com/kbuley/reactdevcontainer/actions/workflows/ci.yml)

[![dockeri.co](https://dockeri.co/image/kbuley/reactdevcontainer)](https://hub.docker.com/r/kbuley/reactdevcontainer)

![Last Docker tag](https://img.shields.io/docker/v/kbuley/reactdevcontainer?sort=semver&label=Last%20Docker%20tag)
[![Latest size](https://img.shields.io/docker/image-size/kbuley/reactdevcontainer/latest?label=Latest%20image)](https://hub.docker.com/r/kbuley/reactdevcontainer/tags)

![Last release](https://img.shields.io/github/release/kbuley/reactdevcontainer?label=Last%20release)
[![Last release size](https://img.shields.io/docker/image-size/kbuley/reactdevcontainer?sort=semver&label=Last%20released%20image)](https://hub.docker.com/r/kbuley/reactdevcontainer/tags?page=1&ordering=last_updated)
![GitHub last release date](https://img.shields.io/github/release-date/kbuley/reactdevcontainer?label=Last%20release%20date)
![Commits since release](https://img.shields.io/github/commits-since/kbuley/reactdevcontainer/latest?sort=semver)

[![GitHub last commit](https://img.shields.io/github/last-commit/kbuley/reactdevcontainer.svg)](https://github.com/kbuley/reactdevcontainer/commits/main)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/y/kbuley/reactdevcontainer.svg)](https://github.com/kbuley/reactdevcontainer/graphs/contributors)
[![GitHub closed PRs](https://img.shields.io/github/issues-pr-closed/kbuley/reactdevcontainer.svg)](https://github.com/kbuley/reactdevcontainer/pulls?q=is%3Apr+is%3Aclosed)
[![GitHub issues](https://img.shields.io/github/issues/kbuley/reactdevcontainer.svg)](https://github.com/kbuley/reactdevcontainer/issues)
[![GitHub closed issues](https://img.shields.io/github/issues-closed/kbuley/reactdevcontainer.svg)](https://github.com/kbuley/reactdevcontainer/issues?q=is%3Aissue+is%3Aclosed)

![Visitors count](https://visitor-badge.laobi.icu/badge?page_id=reactdevcontainer.readme)

## Features

- Based on [kbuley/basedevcontainer](https://github.com/kbuley/basedevcontainer)
  - Minimal custom terminal and packages
  - Nodejs, npm and yarn downloaded as Alpine packages
  - See more [features](https://github.com/kbuley/basedevcontainer#features)
- Globally installed: `nodemon`, `create-react-app`, `mocha`, and `jest`
- Cross platform
  - Easily bind mount your SSH keys to use with **git**
- Extensible with docker-compose.yml
- Two versions:
  1. **Alpine 3.19** based
     - Image tags `:latest`, `:alpine` and `:alpine-vx.x.x`
     - Size of 925MB
     - ⚠️ does not work on `arm64` due to [vscode-remote-release#4462](https://github.com/microsoft/vscode-remote-release/issues/4462)
  2. **Debian Bookworm Slim** based
     - Image tags `:debian` and `:debian-vx.x.x`
     - Size of 708MB
  3. Ubuntu LTS based
     - Image tags `:ubuntu` and `:ubuntu-vx.x.x`
     - Size of 609MB

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
     docker run -it --rm -v "/yourrepopath:/repository" kbuley/devtainr:v0.2.0 -dev react -path /repository -name projectname
     ```

     Or use the [built binary](https://github.com/kbuley/devtainr#binary)

   - Or manually: download this repository and put the [.devcontainer](.devcontainer) directory in your project.

1. If you have a _.vscode/settings.json_, eventually move the settings to _.devcontainer/devcontainer.json_ in the `"settings"` section as _.vscode/settings.json_ take precedence over the settings defined in _.devcontainer/devcontainer.json_.
1. Open the command palette in Visual Studio Code (CTRL+SHIFT+P) and select `Remote-Containers: Open Folder in Container...` and choose your project directory
1. If you want to use the Debian based image, you can modify the .devcontainer/Dockerfile in your directory.

**Note that by default it will map the port `3000` to a random port on your host, which you can find with `docker ps`**

## Customization

See the [.devcontainer/README.md](.devcontainer/README.md) document in your repository.

## TODOs

- [kbuley/basedevcontainer](https://github.com/kbuley/basedevcontainer) todos

## License

This repository is under an [MIT license](https://github.com/kbuley/reactdevcontainer/master/LICENSE) unless indicated otherwise.
