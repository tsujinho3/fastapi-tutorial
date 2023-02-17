FROM python:3.11-slim

ENV DOCKER true

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PYTHONUTF8 1
ENV PIP_NO_CACHE_DIR off
ENV PIP_DISABLE_PIP_VERSION_CHECK on

# Installed apps
USER root
RUN apt update \
    && apt install -y \
    gcc \
    libmariadb-dev \
    zsh \
    vim \
    exa \
    bat
ENV SHELL /bin/zsh

WORKDIR /root
COPY ./requirements.txt ./
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Logging in as a rootless user
ARG UID=1001
ARG GID=1001
RUN useradd -l -u $UID -o -m rootless \
    && groupmod -g $GID -o rootless
USER rootless


WORKDIR /home/rootless
COPY ./base.zshenv .zshenv
COPY ./base.zshrc .zshrc

WORKDIR /home/rootless/src
