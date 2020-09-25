FROM cm2network/steamcmd:root
LABEL MAINTAINER https://github.com/eiaro/stationeers

ARG DATA_DIR="/stationeers"
ARG STEAMCMD="$STEAMCMDDIR/steamcmd.sh"
ARG STEAMAPPID=600760

RUN pwd

RUN mkdir -p "${DATA_DIR}"
RUN $STEAMCMD +login anonymous +force_install_dir "$DATA_DIR" +app_update "$STEAMAPPID" +quit
RUN chown -R steam:steam "${DATA_DIR}"

VOLUME [ "$DATA_DIR" ]

EXPOSE 27500/udp 27500/tcp 27015/udp

# Launch parameters
USER steam
WORKDIR "$DATA_DIR"
ENV APP_DIR="$APP_DIR"
ENV LOG_DIR="$LOG_DIR"
ENV DATA_DIR="$DATA_DIR"
ENV SAVE_INTERVAL="300"
ENV CLEAR_INTERVAL="60"
ENV WORLD_TYPE="Moon"
ENV WORLD_NAME="Base"
ENTRYPOINT exec "$APP_DIR/rocketstation_DedicatedServer.x86_64" \
    -batchmode \
    -nographics \
    -autostart \
    -basedirectory="$DATA_DIR" \
#    -logfile="$LOG_DIR/game.log" \
    -autosaveinterval="$SAVE_INTERVAL" \
    -clearallinterval="$CLEAR_INTERVAL" \
    -worldtype="$WORLD_TYPE" \
    -worldname="$WORLD_NAME" \
    -loadworld="$WORLD_NAME" 

