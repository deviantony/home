# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"
plugins=(git git-flow vagrant docker history)
source $ZSH/oh-my-zsh.sh

# bashmarks
source ~/bin/bashmarks.sh

# path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# SSH autocomplete
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# system aliases and functions
alias apt-get='sudo apt-get'
alias ..='cd ..'
alias e='emacs -nw'
alias se='sudo emacs -nw'
alias meminfo='free -m -l -t'
alias reboot='sudo /sbin/reboot'
alias shutdown='sudo /sbin/shutdown'
alias h='history'
alias j='jobs -l'
alias mount='mount | column -t'
alias grep='grep --color=auto'
alias del='rm -rf'
alias sdel='sudo rm -rf'
alias du1='du -h --max-depth=1'
alias sdu1='sudo du -h --max-depth=1'
alias publicip='curl "https://api.ipify.org?format=json"'

## git aliases
alias gpat='git push --all && git push --tags'
alias gitbump='git add --all && git commit -m "Bumped version number and updated changelog."'

dluntar() { tar zxv < <(wget -q -O - $1) }

# Docker aliases and functions

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Delete orphaned volumes
alias dcl='docker volume rm $(docker volume ls -qf dangling=true)'

# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Remove untagged images
driut() { docker rmi $(docker images -q --filter "dangling=true") }

# Run interactive container using zsh
dkizsh () { docker run --rm -it -P $1 /bin/zsh }

# Run a deviantony/sandbox container using zsh
sandbox () { docker run --rm -it -v /tmp/docker-sandbox:/shared deviantony/sandbox /bin/zsh }

# docker-compose shortcut
alias dkc="docker-compose"

# docker-compose remove containers
alias dkcrm="docker-compose rm --force"

# docker-compose remove containers, build and up
alias dkcrbu="docker-compose rm --force && docker-compose build && docker-compose up"

### Python virtualenvwrapper

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
