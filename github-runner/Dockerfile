# Use a base image with Ubuntu
FROM ubuntu:latest

# Install dependencies and additional dependencies for GitHub runner
RUN apt-get update && \
    apt-get install -y git curl unzip wget jq iputils-ping sudo libssl-dev libkrb5-3 zlib1g libicu-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install OpenJDK 17 and set JAVA_HOME
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

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

# Add the github user to the sudo group
RUN usermod -aG sudo github

# Allow the github user to execute sudo commands without a password
RUN echo "github ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set the working directory to the home of the non-root user
WORKDIR /home/github/github-runner

# Download and extract the GitHub runner
RUN curl -o actions-runner-linux-arm64-2.319.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.319.0/actions-runner-linux-arm64-2.319.0.tar.gz \
    && tar xzf ./actions-runner-linux-arm64-2.319.0.tar.gz \
    && rm -f ./actions-runner-linux-arm64-2.319.0.tar.gz \
    && chown -R github:github /home/github/github-runner

# Add Defaults !requiretty to sudoers
RUN echo "Defaults !requiretty" >> /etc/sudoers

# Copy the entrypoint script and set permissions
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh \
    && chown github:github ./entrypoint.sh

# Switch to the non-root user
USER github

# Entrypoint
ENTRYPOINT ["./entrypoint.sh"]