FROM ubuntu
LABEL maintainer "Chris Bensch <chris.bensch@gmail.com>"

RUN apt update \
  && apt -y dist-upgrade \
  && apt -y install software-properties-common \
  && add-apt-repository ppa:i2p-maintainers/i2p \
  && apt -y install i2p \
  && apt autoclean -y \
  && apt autoremove -y \
  && rm -rf /var/lib/apt/lists/*

COPY i2p /etc/default/i2p
COPY clients.config /usr/share/i2p/clients.config
COPY router.config /usr/share/i2p/router.config
COPY i2ptunnel.config /usr/share/i2p/i2ptunnel.config
COPY subscriptions.txt /usr/share/i2p/addressbook/subscriptions.txt
COPY hosts.txt /usr/share/i2p/hosts.txt
RUN /etc/init.d/i2p start && sleep 10 && /etc/init.d/i2p stop

CMD /etc/init.d/i2p start && tail -f /var/log/i2p/wrapper.log 

EXPOSE 7654 7656 7657 7658 4444 6668 7659 7660 4445 12345