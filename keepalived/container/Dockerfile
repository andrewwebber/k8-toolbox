FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y -q wget apt-transport-https

# Install NGINX Plus
RUN apt-get update
RUN apt-get install -y curl

RUN apt-get install -y keepalived

RUN mkdir -p /opt/bin
COPY network-interface /opt/bin/
COPY setup-network-environment /opt/bin/

RUN chmod +x /opt/bin/setup-network-environment
RUN chmod +x /opt/bin/network-interface
COPY start.sh /opt/bin/
RUN chmod +x /opt/bin/start.sh
RUN shuf -i 1-250 -n 1

ADD keepalived.conf /etc/keepalived/keepalived.conf

EXPOSE 80 443

ENTRYPOINT ["/opt/bin/start.sh"]
CMD [""]
