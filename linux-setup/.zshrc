autoload -U colors && colors # pretty colors
autoload -Uz vcs_info # enable vcs_info

precmd () { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:*' formats ' %F{yellow}%s(%b)%f' # indicates if you're in git directory

PS1='%F{green}%n(%~)%f$vcs_info_msg_0_ > ' # the prompt

function activate() {
    # checks to see if ssh-agent is active

    if [ $(ps ax | grep "[s]sh-agent" | wc -l) -gt 0 ] ; then
        echo "ssh-agent is already running";
    else
        eval "$(ssh-agent -s)"
    fi

    ssh-add ~/.ssh/GitLab
}

alias check="ssh-add -l"
alias config="vim ~/.zshrc"
