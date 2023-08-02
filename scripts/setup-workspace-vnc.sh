#!/bin/bash
sudo apt update
sudo apt -y install tigervnc-standalone-server openbox lxterminal tint2 firefox
mkdir -p ~/.vnc
cp -v xstartup ~/.vnc
mkdir -p ~/.local/bin
cp -v startvnc ~/.local/bin
