sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
cd ~/Development &&
mkdir mcclowes &&
cd mcclowes && 
git clone https://github.com/mcclowes/oh-my-zsh.git &&
echo "
export ZSH=\"/Users/mcclowes/Development/mcclowes/oh-my-zsh\"

ZSH_THEME=\"bureau\"

plugins=(
  codogo
  experiments
  git
  githubutils
  imagetools
  jestutils
  mcclowes
  pollen
  sublime
  workshare
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

## --------------- User configuration --------------- 

# Sublime as editor
export EDITOR='sublime'

# Paths

PATH=\"/sbin:$PATH\"
PATH=\"/bin:$PATH\"
PATH=\"/usr/sbin:$PATH\"
PATH=\"/usr/bin:$PATH\"
PATH=\"/usr/local/sbin:$PATH\"
PATH=\"/usr/local/bin:$PATH\"

# pyenv
export PYENV_VERSION=\"3.7.3\"
export PYENV_ROOT=\"$HOME/.pyenv\"
PATH=\"$PYENV_ROOT/bin:$PATH\"

# nvm
export NVM_DIR=\"$HOME/.nvm\"
[ -s \"$NVM_DIR/nvm.sh\" ] && \. \"$NVM_DIR/nvm.sh\"  # This loads nvm
[ -s \"$NVM_DIR/bash_completion\" ] && \. \"$NVM_DIR/bash_completion\"  # This loads nvm bash_completion

export PATH

# -- Functions --

# Function to check for updates to the current directory if the CD is a git repo
cd () { builtin cd \"$@\" && cd_git_checker; }
cd_git_checker () { 
  if [ -d .git ]; then
    git fetch
  fi;
}

# Brew automcomplete
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# npmfetch
function npmfetch {
  rm -rf node_modules && npm update --save-dev && npm update --save
}

export PATH=\"$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH\"

" >> ~/.zshrc