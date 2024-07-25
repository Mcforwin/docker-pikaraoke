# docker-pikaraoke
Docker container for the PiKaraoke project

# setup
- copy files to a directory
```shell
cd ~/
git clone https://github.com/Laynezilla/docker-pikaraoke.git
```
- build the image
```shell
docker build -t pikaraoke .
```
- optional: create user to align file permissions between host and container
```shell
sudo adduser --system --group --no-create-home --home ~/docker-pikaraoke pikaraoke
```
- run the container
```shell
docker run \
--name pikaraoke \
-d \
-p 5555-5556:5555-5556 \
-e PUID=$(id -u pikaraoke) \
-e PGID=$(id -g pikaraoke) \
-e PUSER=pikaraoke \
-e PGROUP=pikaraoke \
-e INSTALL_PATH=/pikaraoke \
-e PORT=5555 \
-e FFMPEG_PORT=5556 \
-e DOWNLOAD_PATH=/pikaraoke-songs \
-e VOLUME=0.85 \
-e SPLASH_DELAY=3 \
-e SCREENSAVER_TIMEOUT=300 \
-e LOG_LEVEL=20 \
pikaraoke
```
