FROM debian:latest

# Install packages
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt -y install openssh-server sudo xfce4 xfce4-goodies tightvncserver vim
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
RUN mkdir -p /var/run/sshd
COPY sshd_config /etc/ssh/sshd_config

## Set a default user. Available via runtime flag `--user docker`
## User docker is created with password `docker` and added to sudo group
RUN useradd docker --create-home --shell /bin/bash -p "$(openssl passwd -1 docker)"
RUN usermod -aG sudo docker

EXPOSE 22
CMD ["/run.sh"]
