#!/bin/bash

echo "HI TO ZA-ARCH-INSTALLER"
echo "THIS SCRIPT TO INSTALL BASE ARCH WITH OUT WM"
echo "First Enter Your EFI Partition's Path: "
while true; do
  read efiPath
  if [ -e "$efiPath" ]; then
    break
  fi
  echo "Partition Not Fount, Try Again: "
done

echo $efiPath
