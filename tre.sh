#!/bin/bash
clear;
echo "############ TRE ############";
echo "";
echo -n "Digite a sua idade:";
read idade;
##### estrutura condicional if else
### encadeamento do if, operadores logicos e comparadores
if [ $idade -lt 16 ]; then
echo "Proibido Votar";
elif [ $idade -ge 18 ] &&  [ $idade -le 70 ]; then
echo "Obrigatóri Votar";

elif [ $idade -eq 16 ] || [ $idade -eq 17 ] || [ $idade -gt 70 ]; then
echo "Voto Facultativo";
fi
exit; 
