FROM ubuntu:16.04

ENV BEETSDIR /etc/beets/

# Use latest stable version of ffmpeg
RUN add-apt-repository ppa:jonathonf/ffmpeg-3

RUN apt-get -y update && apt-get install -y \
  locales \
  python3-pip \
  bs1770gain \
  libchromaprint-tools \
  ffmpeg \
  wget

RUN locale-gen en_GB.UTF-8  
ENV LANG en_GB.UTF-8  
ENV LANGUAGE en_GB:en  
ENV LC_ALL en_GB.UTF-8

RUN pip3 install \
  beets[fetchart,lastgenre,chroma,web] \
  beets-copyartifacts \
  flask

# Manually update replaygain.py for Python 3 compatibility - only required in 1.4.3.
RUN wget https://raw.githubusercontent.com/beetbox/beets/master/beetsplug/replaygain.py -O /usr/local/lib/python3.5/dist-packages/beetsplug/replaygain.py

# Manually add the latest version of the Copy Artifacts plugin for Python 3 compatibility.
RUN wget https://raw.githubusercontent.com/sbarakat/beets-copyartifacts/master/beetsplug/copyartifacts.py -O /usr/local/lib/python3.5/dist-packages/beetsplug/copyartifacts.py
  
COPY config.yaml /etc/beets/config.yaml

EXPOSE 8337

VOLUME /etc/beets /music /import /convert

CMD beet web
