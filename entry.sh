#!/bin/bash

echo "DATA_DIR=${DATA_DIR}"
echo "USER=${USER}"

bash

bash "${STEAMCMD}" +login anonymous \
				+force_install_dir "${DATA_DIR}" \
				+app_update "${STEAMAPPID}" \
				+quit

# Assume missing config is a fresh install
if [ ! -f "${DATA_DIR}/default.ini" ]; then
    cp "${DATA_DIR}/rocketstation_DedicatedServer_Data/StreamingAssets/default.ini" ${DATA_DIR}

    sed -i s/SERVERNAME=Stationeers/SERVERNAME="${SERVERNAME}"/g ${DATA_DIR}/default.ini
    sed -i s/GAMEPORT=27500/GAMEPORT=${GAMEPORT}/g ${DATA_DIR}/default.ini
    sed -i s/UPDATERPORT=27015/UPDATERPORT=${UPDATERPORT}/g ${DATA_DIR}/default.ini
    sed -i s/PASSWORD=/PASSWORD=${PASS}/g ${DATA_DIR}/default.ini
    sed -i s/ADMINPASSWORD=AdminPass/ADMINPASSWORD=${ADMINPASSWORD}/g ${DATA_DIR}/default.ini
    sed -i s/MAPNAME=Moon/MAPNAME=${MAPNAME}/g ${DATA_DIR}/default.ini
    sed -i s/DESCRIPTION=Stationeers/DESCRIPTION=${DESCRIPTION}/g ${DATA_DIR}/default.ini
    sed -i s/MAXPLAYER=10/MAXPLAYER=${MAXPLAYER}/g ${DATA_DIR}/default.ini
    sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=${RCONPASSWORD}/g ${DATA_DIR}/default.ini
fi

