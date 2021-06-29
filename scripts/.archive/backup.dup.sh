
# Variables
BACKUP_DIR=$HOME/.local/backups
DROPBOX=$HOME/Dropbox
DROPBOX_BACKUP_DIR=$DROPBOX/Stuff/Backups/

dup=$(which duplicity)
options="--no-encryption --full-if-older-than 1M"

# Notes 
$dup $DROPBOX/Notes file://$BACKUP_DIR/Notes $options
# Anki
# $dup $HOME/.local/share/Anki2 file://$BACKUP_DIR/Anki2 $options

# Cloud backups
# Notes
$dup $DROPBOX/Notes file://$DROPBOX_BACKUP_DIR/Notes $options
# Zotero
$dup $HOME/.AppData/Zotero file://$DROPBOX_BACKUP_DIR/Zotero $options
# Anki
# $dup $HOME/.local/share/Anki2 file://$DROPBOX_BACKUP_DIR/Anki2 $options
# Dotfiles
$dup $HOME/.local/dotfiles file://$DROPBOX_BACKUP_DIR/Dotfiles $options
# Scripts
$dup $HOME/.scripts file://$DROPBOX_BACKUP_DIR/Scripts $options
# Projects
$dup $DROPBOX/Projects file://$DROPBOX_BACKUP_DIR/Projects $options
# TT-RSS
sudo mysqldump ttrss > $DROPBOX_BACKUP_DIR/tt-rss.sql

## GIT BACKUPS

function git_backup {
    git add -u
    echo "Auto-commit:" $(date) | xargs -0 git commit -m
    git push -u origin develop
}
# # Emacs.d
# $dup --include $HOME/.emacs.d/init.el --include $HOME/.emacs.d/package-list.el --exclude "**" $HOME/.emacs.d/ file://$DROPBOX_BACKUP_DIR/Emacs $options

# # Emacs git backup
# cd $HOME/.emacs.d/
# git add -u
# echo "Auto-commit:" $(date) | xargs -0 git commit -m
# git push -u origin master

echo -e "DOOM EMACS\n============"
# doom.d
$dup $HOME/.doom.d file://$DROPBOX_BACKUP_DIR/Doom $options
# Doom git backup
# cd $HOME/.doom.d/
# git_backup
# git add -u
# echo "Auto-commit:" $(date) | xargs -0 git commit -m
# git push -u origin master

# Dotfiles git backup
echo -e "DOTFILES\n========"
alias dots='/usr/bin/git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME'
dots add -u
dots commit -m "Auto-commit: $(date)"
dots push -u origin master

echo -e "DELETION\n========"
# Delete older backups
time="2M" # 3 months
dup_remove="$dup remove-older-than $time"
options="--no-encryption --force"
$dup_remove file://$DROPBOX_BACKUP_DIR/Notes $options
$dup_remove file://$DROPBOX_BACKUP_DIR/Projects $options
$dup_remove file://$DROPBOX_BACKUP_DIR/Zotero $options
$dup_remove file://$DROPBOX_BACKUP_DIR/Scripts $options
$dup_remove file://$DROPBOX_BACKUP_DIR/Doom $options
$dup_remove file://$DROPBOX_BACKUP_DIR/Emacs $options
