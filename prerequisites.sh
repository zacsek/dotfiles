#!/usr/bin/env bash

set -euo pipefail
IFS=$'\t\n\0'
shopt -s lastpipe

sudo apt update && sudo apt install ansible git

git clone https://github.com/zacsek/dotfiles2 --depth 1 && cd ansible_dotfile_playbook

ansible-playbook -i inventory.ini playbook_dotfile.yaml 
