#!/bin/bash
FILE=p2.txt

INIC=""
PREV=""
NEXT=""
while IFS= read -r N; do
    if [ -z "$PREV" ]; then
        PREV=$N
        INIC=$N
        continue
    fi
    RES=`expr $N - $PREV`
    if [ $RES -gt 1 ]; then
        echo "${INIC}-$PREV"
        INIC=$N
        PREV=$N
    else
        PREV=$N
    fi
done < $FILE
echo "${INIC}-$N"
