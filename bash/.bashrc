# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

eval "$(oh-my-posh init bash)"
eval "$(oh-my-posh init bash --config ~/.cache/oh-my-posh/themes/amro.omp.json)"
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc
fastfetch
# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# zoxide
eval "$(zoxide init bash)"
export _ZO_DOCTOR=0

# Alias
alias c=clear
alias vi=nvim
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push -u origin main"
alias gs="git status"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# ani-cli
ac() {
  if ! command -v ani-cli >/dev/null 2>&1; then
    echo "ani-cli is not installed or not in PATH."
    return 1
  fi

  # --- List genres ---
  if [ "$1" = "--list-genres" ]; then
    echo "Fetching available genres ..."
    curl -s -X POST https://graphql.anilist.co \
      -H "Content-Type: application/json" \
      -d '{"query":"{ GenreCollection }"}' |
      jq -r '.data.GenreCollection[]' | sort
    return 0
  fi

  # --- Genre search ---
  if [ "$1" = "genre" ] && [ -n "$2" ]; then
    genre="$2"
    shift 2

    # Flags
    use_dub=false
    use_download=false

    # Parse extra args (dub, -d)
    for arg in "$@"; do
      case "$arg" in
      dub) use_dub=true ;;
      -d) use_download=true ;;
      esac
    done

    echo "Fetching top anime for genre: $genre ..."

    # Fetch titles as array
    mapfile -t titles < <(curl -s -X POST https://graphql.anilist.co \
      -H "Content-Type: application/json" \
      -d '{"query":"{ Page(page:1, perPage:25) { media(type:ANIME, sort:POPULARITY_DESC, genre_in:[\"'"$genre"'\"]) { title { romaji } } } }"}' |
      jq -r '.data.Page.media[].title.romaji')

    if [ ${#titles[@]} -eq 0 ]; then
      echo "No anime found for genre: $genre"
      return 1
    fi

    echo "Select an anime:"
    select title in "${titles[@]}"; do
      if [ -n "$title" ]; then
        cmd=(ani-cli "$title")
        $use_dub && cmd+=("--dub")
        $use_download && cmd+=("-d")
        ANI_CLI_PLAYER="vlc" "${cmd[@]}"
        break
      fi
    done
    return 0
  fi

  # --- Normal ani-cli usage ---
  args=("$@")
  use_dub=false
  use_download=false

  # Check for flags at the end
  for ((i = ${#args[@]} - 1; i >= 0; i--)); do
    case "${args[i]}" in
    dub)
      unset 'args[i]'
      use_dub=true
      ;;
    -d)
      unset 'args[i]'
      use_download=true
      ;;
    esac
  done

  cmd=(ani-cli "${args[@]}")
  $use_dub && cmd+=("--dub")
  $use_download && cmd+=("-d")

  ANI_CLI_PLAYER="vlc" "${cmd[@]}"
}

# up/down arrows search history in Bash
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export PATH=$PATH:/home/nf/.spicetify
export PATH=$PATH:/home/nf/.local/bin

export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
export SPARK_HOME="/opt/spark-3.5.7-bin-hadoop3"
export PATH="$JAVA_HOME/bin:$SPARK_HOME/bin:$PATH"

. "$HOME/.local/share/../bin/env"

# Added by dbt installer
export PATH="$PATH:/home/nf/.local/bin"

# dbt aliases
alias dbtf=/home/nf/.local/bin/dbt
