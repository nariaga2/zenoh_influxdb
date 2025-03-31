FROM ubuntu:jammy

ARG USERNAME=ecmpg
ARG USER_UID=1000
ARG USER_GID=$USER_UID


RUN if ! id -u $USER_UID >/dev/null 2>&1; then \
        groupadd --gid $USER_GID $USERNAME && \
        useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME; \
    fi
# Add sudo support for the non-root user
RUN apt-get update && \
    apt-get install -y sudo && \
    echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# Switch from root to user
USER $USERNAME


# Update all packages
RUN sudo apt update && sudo apt upgrade -y

# Install Git
RUN sudo apt install -y \
    curl \
    nano \
    python3 \
    tree \
    wget

# Setup Zenoh 1.1.1
RUN sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
RUN sudo echo "deb [trusted=yes] https://download.eclipse.org/zenoh/debian-repo/ /" | sudo tee -a /etc/apt/sources.list > /dev/null
RUN sudo apt update
RUN sudo apt-get install -y \
    zenoh=1.1.1 \
    zenohd=1.1.1 \
    zenoh-backend-influxdb-v2=1.1.1 \
    zenoh-plugin-rest=1.1.1 \
    zenoh-plugin-storage-manager=1.1.1 
RUN sudo cp /etc/apt/sources.list.backup /etc/apt/sources.list
RUN sudo rm /etc/apt/sources.list.backup

# Modified from: https://docs.influxdata.com/influxdb/v2/install/?t=Linux
RUN echo 'deb [trusted=yes] https://repos.influxdata.com/debian stable main' \
    | sudo tee /etc/apt/sources.list.d/influxdata.list  > /dev/null
RUN sudo apt-get update && sudo apt-get install -y influxdb2


# Add start influxdb service to bashrc
RUN echo "sudo service influxdb start" >> ~/.bashrc

RUN cat entrypoint.sh | sudo tee /zenoh_entrypoint.sh > /dev/null
RUN sudo chmod +x /zenoh_entrypoint.sh && sudo chown $USERNAME /zenoh_entrypoint.sh
ENTRYPOINT ["/bin/bash", "/zenoh_entrypoint.sh"]
CMD ["bash"]
