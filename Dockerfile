# Run Chrome in a container
#
#docker run -td \
#    --net host \
#    --cpuset-cpus 0 \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -e DISPLAY=unix$DISPLAY \
#    -v $HOME/Downloads:/root/Downloads \
#    --device /dev/snd \
#    -m 500000000 \
#    -v /dev/shm:/dev/shm \
#    --name chrome \
#    albertalvarezbruned/chrome
#
#	--memory 512mb \ # max memory it can use -> it doesn't work for me
# Base docker image
FROM debian:sid
MAINTAINER Albert Alvarez

# Install Chrome

RUN apt-get update && apt-get install -y 
#apt-transport-https \
#ca-certificates \
#curl \
#gnupg \
#hicolor-icon-theme \
#libgl1-mesa-dri \
#libgl1-mesa-glx \
#libpulse0 \
#libv4l-0 \
#fonts-symbola \
#--no-install-recommends \
#&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
#&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
#&& apt-get update && apt-get install -y \
#google-chrome-stable \
#--no-install-recommends \
#&& dpkg -i '/src/google-talkplugin_current_amd64.deb' \
#&& apt-get purge --auto-remove -y curl \
#&& rm -rf /var/lib/apt/lists/* \
#&& rm -rf /src/*.deb
RUN apt-get install -y wget gnupg gnupg2 gnupg1
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update 
RUN apt-get install -y google-chrome-stable 

COPY local.conf /etc/fonts/local.conf



# Autorun chrome
ENTRYPOINT [ "google-chrome" ]
CMD [ "--user-data-dir=/data" ]
