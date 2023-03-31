FROM openjdk:11-buster

# Install dependencies
RUN apt-get update && \
    apt-get install -y git curl unzip wget && \
    rm -rf /var/lib/apt/lists/*

# Install Android SDK
RUN curl -s https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip --output commandline.zip && \
    unzip commandline.zip -d /sdk && \
    rm commandline.zip

# Set environment variables
ENV ANDROID_HOME /sdk
ENV PATH ${PATH}:${ANDROID_HOME}/cmdline-tools/bin:${ANDROID_HOME}/platform-tools

# Accept licenses
RUN yes | sdkmanager --licenses

# Install Android build tools and platform
RUN sdkmanager "build-tools;33.0.1" "platforms;android-33"

