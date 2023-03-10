# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mitzuri/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
export SHELL

alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'
alias qutebrowser="qutebrowser --qt-flag disable-seccomp-filter-sandbox"

export GUIX_PROFILE="/home/mitzuri/.guix-profile"
source "$GUIX_PROFILE/etc/profile"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
export NODE_PATH="/home/mitzuri/.guix-profile/lib/node_modules${NODE_PATH:+:}$NODE_PATH"
export NIX_REMOTE=daemon
export C_INCLUDE_PATH="/home/mitzuri/.guix-profile/include${C_INCLUDE_PATH:+:}$C_INCLUDE_PATH"
export CPLUS_INCLUDE_PATH="/home/mitzuri/.guix-profile/include${CPLUS_INCLUDE_PATH:+:}$CPLUS_INCLUDE_PATH"
export LIBRARY_PATH="/home/mitzuri/.guix-profile/include${LIBRARY_PATH:+:}$LIBRARY_PATH"
export NIX_PROFILES=(/nix/var/nix/profiles/default $HOME/.nix-profile)

for i in $NIX_PROFILES; do
        export PATH="${PATH}:${i}/bin"
done

export PATH="/home/mitzuri/.config/guix/current/bin${PATH:+:}${PATH}"

if [ ! -e $HOME/.nix-defexpr -o -L $HOME/.nix-defexpr ]; then
        echo "creating $HOME/.nix-defexpr" >&2
        rm -f $HOME/.nix-defexpr
        mkdir $HOME/.nix-defexpr
        if [ "$USER" != root]; then
                ln -s /nix/var/nix/profiles/per-user/root/channels \
                $HOME/.nix-defexpr/channels_root
        fi
fi

if test "$USER" != root; then
        export NIX_REMOTE=daemon
else
        export NIX_REMOTE=
fi

export EDITOR="hx"
export PATH="/home/mitzuri/.cargo/bin:/home/mitzuri/.local/bin:$PATH"
#export BSD_GAMES_DIR=/var/multiplayer
#export BSD_GAMES_DIR=~/.local/share/bsd-games

eval "$(starship init zsh)"
