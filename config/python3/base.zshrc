### COLOR SETTING ###
# Colourised zsh
autoload -Uz colors
colors
export CLICOLOR=true


### COMPLEMENT SETTING ###
# Correct command spellings
setopt correct
setopt correct_all

# Complement commands
autoload -U compinit
compinit
#
setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types
bindkey "^[[Z" reverse-menu-complete
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)ZLS_COLORS}
#zstyle ':completion:*default' list-colors $ZLS_COLORS
setopt auto_param_keys
setopt auto_param_slash
setopt mark_dirs
setopt magic_equal_subst
setopt complete_in_word
setopt always_last_prompt
setopt globdots

# HISTORY SETTING
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_reduce_blanks

# PROMPT SETTING
local mark="%(?,%(!,%F{yellow}#%f,%F{yellow}$%f),%F{magenta}%(!,#,$)%f)"
PROMPT="%n@%m $mark"
RPROMPT="(%F{blue}%~%f)"
SPROMPT="\"%F{yellow}%r%f\" is correct? [Yes(y), No(n), Abort(a), Edit(e)]:"

if [ $SSH_CONNECTION ]; then
PROMPT="%F{red}[%m]%f %n@%m $mark"
RPROMPT="(%F{blue}%~%f) %F{red}[%m]%f"
fi

if [ -v DOCKER ]; then
PROMPT="%F{red}[docker]%f %n@%m $mark"
RPROMPT="(%F{blue}%~%f) %F{red}[docker]%f"
fi

# OTHER SETTING
setopt auto_cd


# ALIAS
alias rm='rm -i'
alias ls='exa'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'

alias ssh='ssh -Y'
alias scp='scp -r'

function cdls() {
    # Add `\` to avoid looping alias.
    \cd $1;
    ls;
}
alias cd=cdls
