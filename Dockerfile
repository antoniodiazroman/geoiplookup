FROM debian:buster-slim

RUN apt-get update && apt-get install -y parallel geoip-bin

RUN mkdir /opt/geoip

WORKDIR /opt/geoip

COPY geoiplookup.sh .

RUN chmod +x ./geoiplookup.sh

RUN touch /opt/hosts.txt

ENTRYPOINT [ "/opt/geoip/geoiplookup.sh" ]

CMD [ "/opt/hosts.txt" ]
