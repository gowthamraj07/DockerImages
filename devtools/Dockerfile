FROM debian:latest

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ripgrep wget git zsh zplug && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Set default shell to zsh
SHELL ["/bin/zsh"]
