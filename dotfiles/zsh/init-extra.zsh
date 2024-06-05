HISTFILE=$HOME/Documents/zsh/.histfile
KEYTIMEOUT=1

# Do not require a leading '.' in a filename to be matched explicitly
setopt GLOBDOTS

# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, even if the duplicates are not contiguous.
setopt HIST_FIND_NO_DUPS

# If a new command line being added to the history list duplicates an older one,
# the older command is removed from the list (even if it is not the previous event).
setopt HIST_IGNORE_ALL_DUPS

# Remove superfluous blanks from each command line being added to the history list
setopt HIST_REDUCE_BLANKS

# When writing out the history file, older commands that duplicate newer ones are omitted.
setopt HIST_SAVE_NO_DUPS

# immediately appends new commands to the histfile
setopt INC_APPEND_HISTORY

# Shaddapayourface
unsetopt BEEP

# clashes with INC_APPEND_HISTORY
unsetopt SHARE_HISTORY

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238

pasteinit() {
    OLD_SELF_INSERT=''${''${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

if [ -f $HOME/Documents/dotfiles/private.zsh ]; then
    source $HOME/Documents/dotfiles/private.zsh
fi

# jujutsu completion
source <(jj util completion zsh)

EDITOR=nvim
