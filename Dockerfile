FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -q --fix-missing \
    && apt install -y postfix rsyslog \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/* /tmp/*

RUN postconf -e "smtputf8_enable = yes" \
	&& postconf -e "inet_interfaces = all" \
	&& postconf -e "mynetworks = 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16" 

EXPOSE 25

# CMD ["/usr/lib/postfix/master", "-d"]
CMD service rsyslog start && service postfix start && tail -f /var/log/mail.log


