## Example of usage:
## Modify the following paths appropriately
## CAUTION: use only absolute paths below!!!

#!/bin/bash

FOLDER=~/real
OUTPUT_DIR_BASE="${FOLDER}/out_real"
CONFIG_SCRIPT="${FOLDER}/ask4.cfg"

# Lock #
NAME=DMUTEX ## or DTAS_CAS or DTAS_TS or DTTAS_CAS or DTTAS_TS or DMUTEX

# Declare an array of string with type
declare -a StringArray=("DMUTEX" "DTAS_TS" "DTAS_CAS" "DTTAS_TS" "DTTAS_CAS")

LockOutDir="${OUTPUT_DIR_BASE}/$NAME"
mkdir -p $LockOutDir

for lock in "${StringArray[@]}"; do
    echo \"$lock\"
    for thread in 1 2; do
        for grain_size in 1 10 100; do

            outDir=$(printf "%s.THR_%02d-GS_%03d.out" $NAME $thread $grain_size)
            outDir="${OUTPUT_DIR_BASE}/$lock/${outDir}"
            mkdir -p $outDir

            sniper_cmd="${FOLDER}/$lock $thread 100000000 $grain_size &> ${outDir}/sim.out"
            echo \"$sniper_cmd\"
            /bin/bash -c "$sniper_cmd"

        done
    done
done

