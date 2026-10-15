#!/bin/bash

if [ -z "$1" ]
then
  echo "Viga: IP-aadress on puudu!"
  echo "Kasutamine: ./kontrolli_vorku.sh <IP-aadress>"
  exit 1
fi

sihtpunkt=$1

if ping -c 1 $sihtpunkt &> /dev/null
then
  echo "[ok]vork toimib: seade $sihtpunkt on kattesaadav."
else
  echo "[viga] Probleem vorguga: seade $sihtpunkt ei vasta!"
fi

