# Use a imagem base do Ubuntu 18.04
FROM ubuntu:18.04

# Atualize o sistema operacional e instale o servidor SSH
RUN apt-get update && apt-get upgrade -y && apt-get install -y openssh-server wget tar lib32gcc1 tmux curl git nano net-tools ufw

# Configurar o servidor SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config

# Expor a porta 22 para permitir conexões SSH
EXPOSE 22
EXPOSE 2302/udp

# Execute o servidor SSH quando o contêiner for iniciado
CMD ["/usr/sbin/sshd", "-D"]
