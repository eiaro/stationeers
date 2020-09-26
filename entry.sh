#!/usr/bin/env bash

bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
				+force_install_dir "${STEAMAPPDIR}" \
				+app_update "${STEAMAPPID}" \
				+quit

# Assume missing config is a fresh install
if [ ! -f "${STEAMAPPDIR}/default.ini" ]; then
    cp $STEAMAPPDIR/rocketstation_DedicatedServer_Data/StreamingAssets/default.ini $STEAMAPPDIR

    if [ -z $RCONPASSWORD ]; then
        sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=$(pwgen 15 1)/g $STEAMAPPDIR/default.ini
    else
        sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=$RCONPASSWORD/g $STEAMAPPDIR/default.ini
    fi 
fi

