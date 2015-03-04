FROM       ubuntu:14.04
MAINTAINER AshDev <ashdevfr@gmail.com>

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:toor' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#Port 22/Port 22\nPort 443/g' /etc/ssh/sshd_config
#RUN printf "\nMatch User root\n   AllowTcpForwarding yes\n   X11Forwarding no\n" >> /etc/ssh/sshd_config
RUN cat /etc/ssh/sshd_config

EXPOSE 22
EXPOSE 443

CMD ["/usr/sbin/sshd", "-D"]