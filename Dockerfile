# Run Chrome in a container
#
# docker run --rm -td \
#	--net host \
#	--cpuset-cpus 0 \
#	-v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
#	-e DISPLAY=unix$DISPLAY \
#	-v $HOME/Downloads:/home/chromeuser/Downloads \
#	-v $HOME/.config/google-chrome/:/data \ # if you want to save state
#	--device /dev/snd \ # so we have sound
#	-v /dev/shm:/dev/shm \
#	--name chrome \
#	albertalvarezbruned/chrome
#
#	--memory 512mb \ # max memory it can use -> it doesn't work for me
# Base docker image
FROM debian:sid
MAINTAINER Albert Alvarez

ADD https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb /src/google-talkplugin_current_amd64.deb

# Install Chrome
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	hicolor-icon-theme \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpulse0 \
	libv4l-0 \
	fonts-symbola \
	--no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
	&& apt-get update && apt-get install -y \
	google-chrome-stable \
	--no-install-recommends \
	&& dpkg -i '/src/google-talkplugin_current_amd64.deb' \
	&& apt-get purge --auto-remove -y curl \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /src/*.deb

#RUN useradd $ELUSER -u 1000 -s /bin/bash
COPY local.conf /etc/fonts/local.conf

ENV ELUSER chromeuser    
RUN echo $ELUSER

RUN groupadd -r $ELUSER && useradd -r -g $ELUSER $ELUSER


#RUN mkdir -p /home/$ELUSER
#RUN mkdir -p /home/$ELUSER/Downloads

#RUN chown $ELUSER:$ELUSER -R /home/$ELUSER
#RUN chown $ELUSER:$ELUSER -R /home/$ELUSER/Downloads

ENV HOME /home/$ELUSER

USER $ELUSER
WORKDIR /home/$ELUSER




# Autorun chrome
ENTRYPOINT [ "google-chrome" ]
CMD [ "--user-data-dir=/data" ]
