#!/usr/bin/env bash

bash "${STEAMCMD}" +login anonymous \
				+force_install_dir "${DATA_DIR}" \
				+app_update "${STEAMAPPID}" \
				+quit

# Assume missing config is a fresh install
if [ ! -f "${DATA_DIR}/default.ini" ]; then
    cp "${DATA_DIR}/rocketstation_DedicatedServer_Data/StreamingAssets/default.ini" ${DATA_DIR}

    if [ -z ${RCONPASSWORD} ]; then
        sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=$(pwgen 15 1)/g ${DATA_DIR}/default.ini
    else
        sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=${RCONPASSWORD}/g ${DATA_DIR}/default.ini
    fi 
fi

