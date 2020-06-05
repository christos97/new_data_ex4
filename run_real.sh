## Example of usage:
## Modify the following paths appropriately
## CAUTION: use only absolute paths below!!!

#!/bin/bash
USER_PATH=/home/giorgosskourtsidis
FOLDER="${USER_PATH}/real"
CONFIG_SCRIPT="{FOLDER}/ask4.cfg"
SNIPER_EXE="${USER_PATH}/sniper-7.3/run-sniper"
SPEC_PINBALLS_DIR="${USER_PATH}/cpu2006_pinballs"

# Lock #
NAME=DMUTEX ## or DTAS_CAS or DTAS_TS or DTTAS_CAS or DTTAS_TS or DMUTEX

# Declare an array of string with type
declare -a StringArray=("DMUTEX" "DTAS_TS" "DTAS_CAS" "DTTAS_TS" "DTTAS_CAS")

LockOutDir="${OUTPUT_DIR_BASE}/$NAME"
mkdir -p $LockOutDir

for lock in "${StringArray[@]}"; do
    for thread in 1 2 4 8 16; do
        for grain_size in 1 10 100; do

            outDir=$(printf "%s.THR_%02d-GS_%03d.out" $NAME $thread $grain_size)
            outDir="${LockOutDir}/${outDir}"

            sniper_cmd="${FOLDER}/$lock -d ${outDir} $thread 100000 $grain_size"
            echo \"$sniper_cmd\"
            /bin/bash -c "$sniper_cmd"

        done
    done
done

