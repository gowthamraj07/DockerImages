# Use the provided base image with Java 17 and Android SDK
FROM openjdk:17.0.1-buster

# Install dependencies
RUN apt-get update && \
    apt-get install -y git curl unzip wget && \
    rm -rf /var/lib/apt/lists/*

# Additional dependencies for GitHub runner
RUN apt-get update && apt-get install -y \
    jq \
    iputils-ping \
    sudo \
    libicu66 \
    libssl-dev \
    libkrb5-3 \
    zlib1g \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Android SDK
RUN curl -s https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip --output commandline.zip && \
    unzip commandline.zip -d /sdk && \
    rm commandline.zip

# Move necessary files to `latest` folder
RUN mkdir /sdk/cmdline-tools/latest
RUN mv /sdk/cmdline-tools/bin /sdk/cmdline-tools/latest/bin
RUN mv /sdk/cmdline-tools/lib /sdk/cmdline-tools/latest/lib
RUN mv /sdk/cmdline-tools/source.properties /sdk/cmdline-tools/latest/source.properties
RUN mv /sdk/cmdline-tools/NOTICE.txt /sdk/cmdline-tools/latest/NOTICE.txt

# Set environment variables
ENV ANDROID_HOME /sdk
ENV PATH ${PATH}:${ANDROID_HOME}/cmdline-tools/bin:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools

# Accept licenses
RUN yes | sdkmanager --licenses

# Install Android build tools and platform
RUN sdkmanager "build-tools;34.0.0" "platforms;android-34"

# Create a non-root user for the runner
RUN useradd -m -s /bin/bash github

# Set the working directory to the home of the non-root user
WORKDIR /home/github/github-runner

# Download and extract the GitHub runner
RUN curl -o actions-runner-linux-arm64-2.319.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.319.0/actions-runner-linux-arm64-2.319.0.tar.gz \
    && tar xzf ./actions-runner-linux-arm64-2.319.0.tar.gz \
    && rm -f ./actions-runner-linux-arm64-2.319.0.tar.gz \
    && chown -R github:github /home/github/github-runner

# Copy the entrypoint script and set permissions
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh \
    && chown github:github ./entrypoint.sh

# Switch to the non-root user
USER github

# Entrypoint
ENTRYPOINT ["./entrypoint.sh"]