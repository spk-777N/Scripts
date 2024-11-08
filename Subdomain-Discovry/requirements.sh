#!/bin/bash

sudo apt install sublist3r
sudo apt install jq
sudo apt install sed
sudo apt install sort
sudo apt install subfinder
sudo apt install knockpy
sudo apt install assetfinder
curl -LO https://github.com/findomain/findomain/releases/latest/download/findomain-linux-i386.zip
unzip findomain-linux-i386.zip
sudo chmod +x findomain
sudo mv findomain /usr/bin/
sudo rm -r findomain-linux-i386.zip
echo "
    Installation completed (:
"