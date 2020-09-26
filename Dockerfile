FROM cm2network/steamcmd:root
LABEL MAINTAINER https://github.com/eiaro/stationeers

ENV DATA_DIR="/stationeers"
ENV STEAMCMD="${STEAMCMDDIR}/steamcmd.sh"
ENV STEAMAPPID=600760

RUN mkdir -p "${DATA_DIR}"
RUN chown -R "${USER}:${USER}" "${DATA_DIR}"

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests pwgen gosu \
  	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm --no-preserve-root -rf /var/lib/apt/lists/* 

COPY entry.sh /

#RUN su steam -c "${STEAMCMD} +login anonymous +force_install_dir ${DATA_DIR} +app_update ${STEAMAPPID} +quit"


VOLUME [ "$DATA_DIR" ]

EXPOSE 27500/udp 27500/tcp 27015/udp

# Launch parameters
USER steam

ENV APP_DIR="$APP_DIR"
ENV LOG_DIR="$LOG_DIR"
ENV DATA_DIR="$DATA_DIR"
ENV SAVE_INTERVAL="300"
ENV CLEAR_INTERVAL="60"
ENV WORLD_TYPE="Moon"
ENV WORLD_NAME="Base"

CMD ["bash", "/entry.sh"]

#ENTRYPOINT exec "$APP_DIR/rocketstation_DedicatedServer.x86_64" \
#    -batchmode \
#    -nographics \
#    -autostart \
#    -basedirectory="$DATA_DIR" \
#    -logfile="$LOG_DIR/game.log" \
#    -autosaveinterval="$SAVE_INTERVAL" \
#    -clearallinterval="$CLEAR_INTERVAL" \
#    -worldtype="$WORLD_TYPE" \
#    -worldname="$WORLD_NAME" \
#    -loadworld="$WORLD_NAME" 