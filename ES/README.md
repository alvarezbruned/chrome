# chrome
xhost +local:docker
docker run -td \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY=unix$DISPLAY \
-v $HOME/Downloads:/home/chromeuser/Downloads \
-m 500000000 \
-v /dev/shm:/dev/shm \
--name chrome \
albertalvarezbruned/chrome:ES

example compose:

version: '2'
services:
  chrome_01:
    image: 'albertalvarezbruned/chrome:ES'
    container_name: 'chrome_01'
    volumes:
      - '/tmp/.X11-unix:/tmp/.X11-unix'
      - '$HOME/Downloads:/root/Downloads'
      - '$HOME/.config/google-chrome/:/data'
      - '/dev/shm:/dev/shm'
    mem_limit: 2500000000
    environment:
      - 'DISPLAY=unix$DISPLAY'
    command: 'google-chrome "http://mywebsite.com" --new-tab "https://www.atlassian.net/" --new-tab "http://www.slack.com"'
  chrome_02:
    image: 'albertalvarezbruned/chrome:ES'
    container_name: 'chrome_02'
    volumes:
      - '/tmp/.X11-unix:/tmp/.X11-unix'
      - '$HOME/Downloads:/root/Downloads'
      - '$HOME/.config/google-chrome/:/data'
      - '/dev/shm:/dev/shm'
    mem_limit: 2500000000
    environment:
      - 'DISPLAY=unix$DISPLAY'
    command: 'google-chrome "http://mywebsite2.com" --new-tab "https://www.gmail.com/"'
