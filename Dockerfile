From ubuntu:bionic
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y tzdata
RUN echo "Asia/Tokyo\n" > /etc/timezone
RUN /usr/sbin/dpkg-reconfigure -f noninteractive tzdata
RUN echo debconf postfix/mailname select "%%mailname%%" | debconf-set-selections
RUN echo debconf postfix/relayhost select "%%relayhost%%" | debconf-set-selections
RUN echo debconf postfix/main_mailer_type select smarthost | debconf-set-selections
RUN echo debconf postfix/mynetworks select 127.0.0.0/8 "%%mynetwork%%" | debconf-set-selections
RUN echo debconf postfix/chattr select false | debconf-set-selections
RUN echo debconf postfix/recipient_delim select | debconf-set-selections
RUN echo debconf postfix/destinations select localhost.localdomain, localhost | debconf-set-selections
RUN echo debconf postfix/protocols select ipv4 | debconf-set-selections
RUN echo debconf postfix/mailbox_limit select 0 | debconf-set-selections
RUN echo debconf postfix/root_address select "%%rootaddress%%" | debconf-set-selections
RUN apt update && apt -y install postfix rsyslog
RUN sed -i "s/ y / n /" /etc/postfix/master.cf
COPY start.sh /start.sh
CMD /start.sh
