FROM openjdk:19-buster

# Install dependencies
RUN apt-get update && \
    apt-get install -y git curl unzip wget && \
    rm -rf /var/lib/apt/lists/*

# Install Android SDK
RUN curl -s https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip --output commandline.zip && \
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
RUN sdkmanager "build-tools;33.0.1" "platforms;android-33"

