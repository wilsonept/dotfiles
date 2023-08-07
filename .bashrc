# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|xterm|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\e]0;u@\h:\w\a\]\u@\[\e[1;32m\]\h\[\e[m\]:\[\e[38;5;6m\]\w\[\e[m\]\$ '

    # Default Value, uncomment this if you need it
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|uxterm*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alh --sort=time --color=auto'
#alias la='ls -A'
#alias l='ls -CF'

# vAir bare repository for testing, may be deleted
alias vair-static='/usr/bin/git \
                       --git-dir=$HOME/vair-bare \
                       --work-tree=/'
alias vs=vair-static


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#:::::::::::::::::::
# CUSTOM FUNCTIONS 
#:::::::::::::::::::

gcm() { # Getting list of custom .bashrc functions
    cat ~/.bashrc | grep -Ev "^\s" | grep -E '^\w+\s?\()' | awk '{s="";for(i=4;i<=NF;i++)s=s $i " ";print $1" "s}' | nl -w2 -s'. '
}

cmount() { # Mount c$ directory of specified host to /mnt folder
    sudo mount.cifs \\\\$1\\c$ /mnt -o username=zaharchenko domain=INTER.local
}

burn() { # Записать указанную директорию на /dev/sr0
    # TODO add checks for filepath
    # if filepath is .iso file:
    #    sudo wodim dev=/dev/sr0 -v -data $1
    # elif file is a directory:
    if [ "$EUID" -ne 0 ]; then 
        echo "Please run as root"
	else
        genisoimage -o /tmp/dvd.iso -R -J -allow-limited-size $1
        wodim dev=/dev/sr0 -v -data /tmp/dvd.iso
    fi
}

burniso() { # Запись файла iso на /dev/sr0
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
	else
        wodim dev=/dev/sr0 -v -data $1
    fi
}

backup() { # Бэкап директории /root (есть исключения) в директорию /backup
    sudo rsync -avHAXS /* --exclude={'lib','lib32','lib64','libx32','srv','usr','var','bin','sbin','proc','sys','dev','run','tmp','mnt','media','lost+found','backup','home/zaharchenko/.cache'} /backup
}

getupdate() { # Скачать обновления определенной версии касперского. Принимает номер версии в качестве параметра.
    case $1 in
    10)
	    echo "lin-10-install.sh activated"
	    sudo /opt/kuu/Scripts/lin-10-install.sh
    ;;
    11)
	    echo "lin-11-install.sh activated"
            sudo /opt/kuu/Scripts/lin-11-install.sh
    ;;
    *)
	    echo "Укажите номер версии 10 или 11 в качестве параметров и повторите попытку"
    esac
}

xkb() { # Чинит переключение языка с клавиатуры
    setxkbmap -option grp:ctrl_shift_toggle 'us,ru'	
}

getkblayout() { # Возвращает тукущий лейаут клавиатуры
    layout=`xset -q | grep 'LED' | cut -c59-67`
    if [[ $layout = 00001002 ]]; then echo 'ru'; else echo 'en'; fi
}

searchkb() { # Поиск пакета обновления для Windosw по номеру наименованию KB.
    query=$1
    brave-browser "https://www.catalog.update.microsoft.com/search.aspx?q=$query"
}

myhelp() { # Набор хелпов
	echo "Error opening terminal: rxvt-unicode-256color. :: export TERM=xterm-256color"
}

vpnconnect() {
    password=$(pass aerodisk/vpn__d.zaharchenko | head -1)
    echo $password | sudo openconnect --user d.zaharchenko \
	                              --authgroup GROUP2 \
				      --servercert pin-sha256:DdgRBQ2Xp9h3GSIIfvv+G+kfAoDbIvwOc1HOFM5/qtw= \
	                              --passwd-on-stdin \
				      109.73.36.242 
}

export EDITOR=vim
export VISUAL=vim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
