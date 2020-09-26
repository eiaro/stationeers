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

    sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=${RCONPASSWORD}/g ${DATA_DIR}/default.ini
     
fi

