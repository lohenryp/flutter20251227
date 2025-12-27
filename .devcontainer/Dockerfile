# See https://aka.ms/vscode-remote/devcontainer.json for config options
ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

ARG FLUTTER_VERSION=stable
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gnupg \
    unzip \
    xz-utils \
    zip \
    fonts-liberation \
    libgl1 \
    libgtk-3-0 \
    libnss3 \
    libxss1 \
    libasound2 \
    libc6 \
    libstdc++6 \
    apt-transport-https \
    wget \
    xvfb \
  && rm -rf /var/lib/apt/lists/*

# Install Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends google-chrome-stable \
  && rm -rf /var/lib/apt/lists/*

# Install Flutter (clone stable branch)
RUN git clone -b ${FLUTTER_VERSION} https://github.com/flutter/flutter.git /usr/local/flutter \
  && chown -R vscode:vscode /usr/local/flutter

# Add Flutter to PATH for all users
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Allow flutter tools to download artifacts in non-root steps
RUN flutter --version || true

# Precache web artifacts on image build to speed up start (best-effort)
RUN flutter precache --web || true

# Expose typical web ports
EXPOSE 8080 3000

USER vscode

# Note: `postCreateCommand` in devcontainer.json will run `flutter doctor -v` and `flutter config --enable-web` to finish setup.
