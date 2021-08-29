#!/bin/bash
FILE=p1.txt
SERVERPREFIX=server

buscaIP(){
    egrep  -no "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
}

buscaServer(){
    egrep -no "$SERVERPREFIX(.*)([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})"
}

checkIP(){
    IP=$1
    shift
    LINE=$1
    shift
    SNAME=$1
    ping -c 1 $IP > /dev/null
    if [ $? -eq 0 ]; then
        echo "El servidor $SNAME con IP $IP está activo"
        sed -i "$LINE s/^#//" $FILE
    else
        echo "El servidor $SNAME con IP $IP está caído"
        sed -i "$LINE s/^[^#]/#/" $FILE
    fi
}

getServer(){
    while IFS= read -r L; do 
            LINE=$(echo $L | cut -d: -f1)
            SNAME=$(echo $L | cut -d: -f2 | cut -d'=' -f1)
            IP=$(echo $L | cut -d'[' -f2)
            #echo $LINE $SNAME $IP
            checkIP $IP $LINE $SNAME
    done < <(buscaServer < $FILE)
}

cp $FILE ${FILE}.src
getServer
diff -q $FILE ${FILE}.src > /dev/null && echo "No se ha modificado nada" || echo "Reiniciar servicio"
rm ${FILE}.src
