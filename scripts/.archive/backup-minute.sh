#!/usr/bin/env bash
set -euo pipefail
BACKUP_DIR=$HOME/.local/backups
DROPBOX=$HOME/Dropbox
DROPBOX_BACKUP_DIR=$DROPBOX/Stuff/Backups/

dup=$(which duplicity)
options="--no-encryption --full-if-older-than 1D"

$dup $DROPBOX/Notes/GCPP/final_assignment file://$DROPBOX_BACKUP_DIR/GCPP_Assignment $options

time="1D" # 1 day
dup_remove="$dup remove-older-than $time"
options="--no-encryption --force"
$dup_remove file://$DROPBOX_BACKUP_DIR/GCPP_Assignment $options
