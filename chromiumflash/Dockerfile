# Run Chrome in a container
#
#docker run -td \
#    --net host \
#    --cpuset-cpus 0 \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -e DISPLAY=unix$DISPLAY \
#    -v $HOME/Downloads:/root/Downloads \
#    -v /home/chromium/data:/root \
#    --device /dev/snd \
#    -m 500000000 \
#    -v /dev/shm:/dev/shm \
#    --name chrome \
#    albertalvarezbruned/chrome:chromium

FROM ubuntu:14.04
MAINTAINER Albert Alvarez

# Install Chromium

RUN apt-get update && apt-get upgrade -y && apt-get install -y chromium-browser

RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:skunk/pepper-flash -y
RUN apt-get install pepflashplugin-installer
RUN echo ". /usr/lib/pepflashplugin-installer/pepflashplayer.sh" >> /etc/chromium-browser/default

#ENTRYPOINT [ "chromium-browser --no-sandbox" ]
ENTRYPOINT [ "chromium-browser" ]
