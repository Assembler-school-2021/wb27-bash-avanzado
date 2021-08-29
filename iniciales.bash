#!/bin/bash

INICIALES=$1
shift

read -p "Introduce el texto donde vas a buscar: " TEXTO
RESULT=""

function split(){
	for I in `seq 0 $(expr ${#INICIALES} - 1)`; do
		echo -n "${INICIALES:$I:1} "
	done
}
for L in `split`; do
	for P in $TEXTO; do
		CAP=${P^}
		if [ "${CAP:0:1}" == "$L" ]; then echo $CAP; fi
	done
done
