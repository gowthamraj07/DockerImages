# Use a base image with Java 17
FROM openjdk:17.0.1-buster

# Set environment variables for Android SDK
ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV PATH ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    wget \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Download and install Android Command Line Tools
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools \
    && cd ${ANDROID_SDK_ROOT}/cmdline-tools \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -O commandlinetools.zip \
    && unzip commandlinetools.zip -d latest \
    && rm commandlinetools.zip

# Ensure sdkmanager is executable
RUN chmod +x ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager

# Install the necessary Android SDK packages
RUN yes | ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --licenses \
    && ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --update \
    && ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager "platform-tools" \
    "platforms;android-34" \
    "build-tools;34.0.0"

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/local/openjdk-17

# Optional: Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-8.7-bin.zip -P /tmp \
    && unzip /tmp/gradle-8.7-bin.zip -d /opt \
    && ln -s /opt/gradle-8.7-bin /opt/gradle \
    && rm /tmp/gradle-8.7-bin.zip
ENV PATH /opt/gradle/bin:${PATH}

# Optional: Install other tools as needed (like Android NDK)
# RUN sdkmanager "ndk-bundle"

# Working directory
WORKDIR /workspace

# Define default command
CMD ["bash"]