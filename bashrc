# make Openwrt bashrc config

clear

#--Color Code;
Cls="\033[0m"
Grey="\033[1;30m"
Red="\033[0;31m"
Green="\033[1;32m"
Yellow="\033[1;33m"
Blue="\033[1;34m"
Purple="\033[1;35m"
Cyan_blue="\033[1;36m"
White="\033[1;38m"

B_Red="\033[41m"
Blue_White="\033[44m"

printf "${Cyan_blue}"
cat << "EOF"

 ██████╗ ██████╗ ███████╗███╗   ██╗██╗    ██╗██████╗ ████████╗
██╔═══██╗██╔══██╗██╔════╝████╗  ██║██║    ██║██╔══██╗╚══██╔══╝
██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║ █╗ ██║██████╔╝   ██║
██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██║███╗██║██╔══██╗   ██║
╚██████╔╝██║     ███████╗██║ ╚████║╚███╔███╔╝██║  ██║   ██║
 ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚══╝╚══╝ ╚═╝  ╚═╝   ╚═╝
                        A-U-R-A

EOF
printf "${Blue}真正意义上使用容器构建的${Purple}Openwrt${Cls}${Blue}开发环境!${Cls}\n"
printf "${Green}详细使用文档${Yellow}👉\t${Cls}"
printf "${Purple}https://github.com/wo2ni/build-auro-openwrt${Cls}\n\n"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

PS1="\[\033[01;37m\]\$? \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi) $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \W 💗\[\033[00m\] "

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias s='ls -CF'
alias gcc="color_compile gcc"
alias g++="color_compile g++"

make='color_compile make'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


while ((1)); do
    printf "选择模式:\n"
    printf "0)${Yellow}输入${Red}0 ${Yellow}or ${Red}exit 退出 ${Purple}Openwrt Buildroot${Cls}\n"
    printf "1)${Yellow}按${Green}任意键${Yellow}进入用户: ${Cyan_blue}${MY_USER} ${Purple}Openwrt Buildroot${Cls}\n"
    printf "2)${Yellow}输入${Green}CTRL+C${Yellow}强制进入root用户.${Cls}\n"
    printf "请选择: "
    read option
    case $option in
        0)
            exit 0
            ;;
        exit)
            exit 0
            ;;
        *)
            printf "${Yellow}已切换用户 ${Purple}$MY_USER ${Green}一切就绪!${Cls}\n"
            su whoami
           ;;
    esac
done
