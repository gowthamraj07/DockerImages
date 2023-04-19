FROM debian:latest

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ripgrep wget git zsh zplug curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && \
    chmod 777 install.sh && \
    ./install.sh --keep-zshrc --unattended

# Set default shell to zsh
SHELL ["/bin/zsh"]
