FROM python:3.9.19-alpine3.20

ENV PUID 1001
ENV PGID 1001
ENV PUSER pikaraoke
ENV PGROUP pikaraoke

ENV INSTALL_PATH /pikaraoke
ENV PORT 5555
ENV FFMPEG_PORT 5556
ENV DOWNLOAD_PATH /pikaraoke-songs
#ENV YOUTUBEDL_PATH $INSTALL_PATH/.venv/bin/yt-dlp
ENV VOLUME 0.85
ENV SPLASH_DELAY 3
ENV SCREENSAVER_TIMEOUT 300
ENV LOG_LEVEL 20

#ENV LOGO_PATH /logo/logo
#ENV URL karaoke.test.tld
#ENV ADMIN_PASSWORD secret

COPY root /

RUN apk add --no-cache --upgrade \
	git=2.45.2-r0 \
	build-base=0.5-r3 \
	python3-dev=3.12.3-r1 \
	linux-headers=6.6-r0 \
	ffmpeg=6.1.1-r8 \
	su-exec=0.2-r3 \
	shadow=4.15.1-r0 && \
	mkdir -m 755 $DOWNLOAD_PATH && \
	git clone https://github.com/vicwomg/pikaraoke.git --branch 1.2 && \
	chmod 755 /usr/local/bin/docker-entrypoint.sh

WORKDIR $INSTALL_PATH

RUN yes y | /bin/sh $INSTALL_PATH/setup.sh

EXPOSE $PORT $FFMPEG_PORT

VOLUME $DOWNLOAD_PATH $INSTALL_PATH

STOPSIGNAL SIGINT

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

#CMD ["$INSTALL_PATH/pikaraoke.sh", "-p $PORT", "-f $FFMPEG_PORT", "-d $DOWNLOAD_PATH", "-y $YOUTUBEDL_PATH", "-v $VOLUME", "-s $SPLASH_DELAY", "-t $SCREENSAVER_TIMEOUT", "-l $LOG_LEVEL", "--headless", "-u $URL"]
CMD ["$INSTALL_PATH/pikaraoke.sh", "-p $PORT", "-f $FFMPEG_PORT", "-d $DOWNLOAD_PATH", "-v $VOLUME", "-s $SPLASH_DELAY", "-t $SCREENSAVER_TIMEOUT", "-l $LOG_LEVEL", "--headless"]
