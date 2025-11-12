FROM ubuntu:latest


RUN apt update && apt install git wget curl neofetch nodejs npm openssh-client -y
RUN mkdir /app
COPY webdav.sh /app/webdav.sh
WORKDIR /app
RUN bash webdav.sh
EXPOSE 10000
CMD bash -c "cloudflared tunnel --url http://localhost:10000 lighttpd -D -f /etc/lighttpd/lighttpd.conf -m /usr/lib/lighttpd"
