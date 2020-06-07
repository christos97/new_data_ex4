# ~/sniper-7.3/tools/advcomparch_mcpat.py -d ~/out/hmmer/hmmer.DW_01-WS_016.out -t total -o ~/out/hmmer/hmmer.DW_01-WS_016.out/power >~/out/hmmer/hmmer.DW_01-WS_016.out/power.total.out

#!/bin/bash

MCPAT=/home/giorgosskourtsidis/sniper-7.3/tools/advcomparch_mcpat.py
OUTPUT_DIR_BASE=/home/giorgosskourtsidis/real/out_real

# Declare an array of string with type
declare -a LOCKS=("DMUTEX" "DTAS_TS" "DTAS_CAS" "DTTAS_TS" "DTTAS_CAS")

for LOCK in "${LOCKS[@]}"; do
    LOCKOutDir=${OUTPUT_DIR_BASE}/$LOCK

    for thread in 1 2 4 8; do
        for gs in 1 10 100; do
            outDir=$(printf "DMUTEX.THR_%02d-GS_%03d.out" $thread $gs)
            outDir="${LOCKOutDir}/${outDir}"
            power="${outDir}/power"

            sniper_cmd="${MCPAT} -d ${outDir} -t total -o ${power} > ${power}.total.out"
            echo \"$sniper_cmd\"
            /bin/bash -c "$sniper_cmd"
        done
    done
done

