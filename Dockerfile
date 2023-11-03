# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables to make the installation non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Update the package repository and install required packages
RUN apt-get update && apt-get install -y \
    lib32gcc1 \
    lib32stdc++6 \
    libcurl4-gnutls-dev:i386 \
    lib32tinfo5 \
    lib32z1 \
    wget \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for SteamCMD and download it
WORKDIR /steamcmd
RUN wget -qO- "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# Set the working directory for SteamCMD
WORKDIR /steamcmd

# Expose a port if needed (e.g., for a game server)
# EXPOSE 27015

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Define the entrypoint script to be executed when the container starts
ENTRYPOINT ["/entrypoint.sh"]
