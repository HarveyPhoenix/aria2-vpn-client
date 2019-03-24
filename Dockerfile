FROM debian:jessie-backports

# install needed debian packages & clean up
RUN	apt-get update -y && \
    apt-get install -y --no-install-recommends curl tar ca-certificates unzip && \
    apt-get install -y python-pip python-dev python-lxml && \
    apt-get install -y python-mysqldb python-m2crypto && \
    apt-get install -y openvpn && \
    apt-get install -y aria2 && \
    apt-get install -y wget && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN adduser --disabled-password --quiet apprunner
RUN mkdir -p /home/apprunner/running
ADD ./start.sh /home/apprunner/running/
WORKDIR /home/apprunner/running/

EXPOSE 26800
CMD ["bash", "start.sh"]
