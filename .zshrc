#######################################################
# Oh My Zsh
#######################################################

export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Accept autosuggestion with Shift-Tab
bindkey '\e[Z' autosuggest-accept


#######################################################
# Aliases
#######################################################

alias cls='clear'
alias off='sudo systemctl poweroff'
alias v='nvim'
alias e='exit'
alias resetgg='rm -f ~/.config/google-chrome/SingletonLock'
alias resetbrave='rm -f ~/.config/BraveSoftware/Brave-Browser/SingletonLock'
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias cfnv="cd ~/.config/nvim/"
alias ntm='tmux new -s'
alias y="yazi"
alias ud="sudo dnf update -y"
alias ls="lsd"

alias parasync='rclone copy ~/Obsidian gdrive:Para/Para --update --verbose'
alias startsqlsever="sudo systemctl start mssql-sever"
alias stopsqlsever="sudo systemctl stop mssql-sever"
alias restartsqlsever="sudo systemctl restart mssql-sever"


#######################################################
# PATH bổ sung
#######################################################

export PATH="$HOME/.emacs.d/bin:$PATH"


#######################################################
# FZF: tìm file và mở bằng nvim
#######################################################

fv() {
  fzf \
    --preview='bat --color=always --style=numbers --line-range=:200 {}' \
    --preview-window=right:70% \
    --bind 'enter:become(nvim {})' \
    --bind 'esc:abort'
}


#######################################################
# FZF: tìm file và mở bằng emacs -nw
#######################################################

fe() {
  local file
  file=$(find . -type f -not -path '*/.git/*' 2>/dev/null | fzf \
    --preview 'bat --color=always --style=numbers --line-range=:200 {}' \
    --preview-window=right:70%)

  if [[ -n "$file" ]]; then
    echo "📂 Đang mở: $file"
    emacs -nw "$file"
  else
    echo "❎ Không có file nào được chọn."
  fi
}


#######################################################
# Markdown → PDF (Kobo)
#######################################################

md2kobo() {
  local input="$1"

  if [[ -z "$input" ]]; then
    echo "Usage: md2kobo <file.md>"
    return 1
  fi

  local base="${input%.md}"

  pandoc "$input" \
    -o "${base}_kobo.pdf" \
    --pdf-engine=xelatex \
    -V geometry:paperwidth=108mm \
    -V geometry:paperheight=144mm \
    -V geometry:margin=6mm \
    -V fontsize=12pt
}

md2kobo_tree() {
  local dir="${1:-.}"

  if [[ ! -d "$dir" ]]; then
    echo "❌ Không phải thư mục: $dir"
    return 1
  fi

  find "$dir" -type f -name '*.md' -print0 | while IFS= read -r -d '' f; do
    md2kobo "$f"
  done
}


#######################################################
# Conda
#######################################################

__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [[ $? -eq 0 ]]; then
  eval "$__conda_setup"
elif [[ -f "/usr/etc/profile.d/conda.sh" ]]; then
  source "/usr/etc/profile.d/conda.sh"
else
  export PATH="/usr/bin:$PATH"
fi
unset __conda_setup


#######################################################
# TERM fix
#######################################################

export TERM=xterm-256color

precmd() {
  if [[ -z "$TERM" || "$TERM" == "''" ]]; then
    export TERM=xterm-256color
  fi
}


#######################################################
# FZF cd directory (CURRENT / HOME)
#######################################################

__fzf_cd_base() {
  local base_dir="$1"
  local dir

  dir=$(fd -t d . "$base_dir" 2>/dev/null | \
        fzf --height=40% \
            --reverse \
            --prompt="cd > " \
            --preview 'ls -la {}')

  if [[ -n "$dir" ]]; then
    cd "$dir"
  fi
}

fzf_cd_current_widget() {
  __fzf_cd_base "$PWD"
}

fzf_cd_home_widget() {
  __fzf_cd_base "$HOME"
}

zle -N fzf_cd_current_widget
zle -N fzf_cd_home_widget

bindkey '^g' fzf_cd_current_widget   # Ctrl+g → current dir
bindkey '^f' fzf_cd_home_widget      # Ctrl+f → HOME
