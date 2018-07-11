#!/bin/bash
clear;
valor=10;
while [ $valor -gt 0 ]
do
echo "valor";
sleep 1;
valor=$[valor-1];
done
echo "Fire ...............";
exit;
