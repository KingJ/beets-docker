FROM ubuntu:16.04

ENV BEETSDIR /etc/beets/

RUN apt-get -y update && apt-get install -y \
  python3-pip \
  bs1770gain \
  libchromaprint-tools \
  ffmpeg 

RUN pip3 install \
  beets[fetchart,lastgenre,chroma,web] \
  flask

COPY config.yaml /etc/beets/config.yaml

EXPOSE 8337

VOLUME /etc/beets /music /import

CMD beet web