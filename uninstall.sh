#!/bin/bash 
echo "Uninstalling lua..."  
while true; do
  read -p "Are you sure?(Yes/No)" ANS
  case $ANS in 
    'Yes') 
       sudo apt purge --autoremove -y lua > uninstall.log
       break;;
    'No') 
       production=0  
       break;;
    *) 
  esac
done

