#!/bin/bash
# for syntax highlighting

[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach
shopt -u globstar

#ble/debug/profiler/start a
## Add this code after "source ble.sh ..."
## debugging ble.sh debug.txt
#function debug/complete-load-hook {
#  filename_debug_log=debug.txt
#  function timestamp-args.advice {
#    echo "$EPOCHREALTIME ${ADVICE_WORDS[*]}" >> "$filename_debug_log"
#  }
#  ble/function#advice \
#    before ble-decode/.hook \
#    timestamp-args.advice
#
#  function timestamp-wrap.advice {
#    echo "$EPOCHREALTIME ${ADVICE_WORDS[0]} start" >> "$filename_debug_log"
#    ble/function#advice/do
#    echo "$EPOCHREALTIME ${ADVICE_WORDS[0]} end" >> "$filename_debug_log"
#  }
#  ble/function#advice \
#    around ble/complete/progcomp/.compgen-helper-prog \
#    timestamp-wrap.advice
#  ble/function#advice \
#    around ble/complete/progcomp/.compgen-helper-func \
#    timestamp-wrap.advice
#}
#blehook/eval-after-load complete debug/complete-load-hook

## OTHER VAR
if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_DATA_HOME=${HOME}/.local/share
  export XDG_CONFIG_HOME=${HOME}/.config
  export XDG_STATE_HOME=${HOME}/.local/state
  export XDG_CACHE_HOME=${HOME}/.cache
  export XDG_DOWNLOAD_DIR=${HOME}/Downloads
fi

# REMOTE KITTY SHELL
if [ -n "$KITTY_REMOTE_SHELL" ]; then
  export REMOTE_HOME=~/.ssh_daru
  export EDITOR=nvim
  export XDG_DATA_HOME=${REMOTE_HOME}/.local/share
  export XDG_CONFIG_HOME=${REMOTE_HOME}/.config
  export XDG_STATE_HOME=${REMOTE_HOME}/.local/state
  export XDG_CACHE_HOME=${REMOTE_HOME}/.cache
  export XDG_DOWNLOAD_DIR=${REMOTE_HOME}/Downloads

  #curl https://raw.githubusercontent.com/jessp01/zaje/master/install_zaje.sh > install_zaje.sh
  #chmod +x install_zaje.sh
  #./install_zaje.sh
  # rm ./install_zaje.sh

  echo "files were sourced successfully"
fi

export SYSTEMD_PAGERSECURE=true
if command -v page >/dev/null; then
  # if different layout use above version
  #export PAGER="page -q 90000 -z 90000"
  export PAGER="page -WC"
  export MANPAGER="page -WC -t man"
  export SYSTEMD_PAGER="$PAGER"
elif command -v nvimpager >/dev/null; then
  export PAGER="nvimpager"
  export MANPAGER="nvimpager"
  export SYSTEMD_PAGER="nvimpager"
else
  export PAGER="nvim -R -c BaleiaColorize"
  export MANPAGER="nvim +Man! -R"
  export SYSTEMD_PAGER="$PAGER"
fi

h() {
  (help "$1" 2>/dev/null ||
    $1 --help 2>/dev/null ||
    $1 -h 2>/dev/null ||
    $1 help ||
    echo "No help entry for $1") | bat -pplhelp
}

# Alternatively, to pick a bit better `man` highlighting:
man() {
  if test $(/bin/man -w "${@:$#}"); then
    if [[ "$PAGER" =~ page.* ]]; then
      if [ $2 ]; then
        $PAGER man://"$2($1)"
      elif [ $1 ]; then
        $PAGER man://"$1"
      fi
    else
      /usr/bin/man "$2" "$1"
    fi
  else
    h "$1"
  fi
  #  SECT=${@[-2]}; PROG=${@[-1]}; page man://"$PROG($SECT)"
}

#just keep both same for same output
HISTSIZE=100000     #writes to memory
HISTFILESIZE=100000 #write to disk
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE='?:??:stty*'
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
#PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
eval "$(atuin init bash --disable-up-arrow)"

## FZF readline search replacement
#source "$XDG_CONFIG_HOME/bash/fzf.bash"
#bind -f $XDG_CONFIG_HOME/bash/inputrc.fzf

#export SESSION_SWITCH="dbus-run-session -- gnome-shell --display-server --wayland"

PS1='[\u@\h \W]\$ '
set -o vi

## nmtui NEWT_COLORS
source "$XDG_CONFIG_HOME/bash/newt_colors"

## clipboard
#source $XDG_CONFIG_HOME/bash/clipboard

[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

## COMPLETION
if [ -n "$KITTY_REMOTE_SHELL" ]; then
  #source "$XDG_DATA_HOME"/bash-completion/bash_completion
  source "$XDG_DATA_HOME"/bash-complete-alias/complete_alias
else
  #source /usr/share/bash-completion/bash_completion
  source /usr/share/bash-complete-alias/complete_alias
  eval "$(register-python-argcomplete pipx)"
fi
#shopt -s progcomp_alias
complete -F _complete_alias SS
complete -F _complete_alias SU
complete -F _complete_alias saj
complete -r oscap

# Enhanced file path completion in bash - https://github.com/sio/bash-complete-partial-path
#if [ -s "$XDG_CONFIG_HOME/bash-complete-partial-path/bash_completion" ]
#then
#    source "$XDG_CONFIG_HOME/bash-complete-partial-path/bash_completion"
#    _bcpp --defaults
#fi

##POWERLINE
source "$XDG_CONFIG_HOME/bash/powerline"

## for echo -e $oct_bell ...
#source /usr/share/icons-in-terminal/icons_bash.sh

# this is used to launch using Ctrl-F
#source /usr/share/wikiman/widgets/widget.bash

##KITTY_INTEGRATION
source "$XDG_CONFIG_HOME/bash/kitty"

##ALIAS
source "$XDG_CONFIG_HOME/bash/alias"
source "$XDG_CONFIG_HOME/bash/xdg-base-dir"

## PYTHON venv
#source "$HOME/.local/bin/bin/activate"

# SHLVL holds number of sessions running on top of shell
# basically print only in first shell
if [ $SHLVL -eq 1 ]; then
  cat /home/daru/Templates/Guides/0usefull-commands-I-always-forget
fi

## NNN
source "$XDG_CONFIG_HOME/bash/nnn"

## Better cd
eval "$(zoxide init bash)"

## Terminal Coloring
#source "$XDG_CONFIG_HOME/zaje/zaje_functions.rc"
GRC_ALIASES=true
[[ -s "/etc/profile.d/grc.sh" ]] && source /etc/profile.d/grc.sh

## PREEXEC functions
#source /usr/share/bash-preexec/bash-preexec.sh
preexec() {
  #content_type=$(ble/fd#alloc _ble_util_fd_cmd_stdout "> >(file -b - | cut -f1 -d' ')" overwrite)
  #content_type=$(ble/fd#alloc _ble_util_fd_cmd_stdout "> >(mimetype --file-compat --output-format %d --stdin| cut -f1 -d' ')" overwrite)
  #pts_before=$(ps -t "$(tty)" | wc -l)

  #for cmd in $(ls /usr/share/grc | cut -f2 -d'.'); do
  #  # grc does it's thing
  #  if [[ $1 = "$cmd" ]]; then
  #    ble/fd#alloc _ble_util_fd_cmd_stdout ">/dev/tty" overwrite
  #  fi
  #done

  if [[ "$*" =~ --help|"help "|" -h" ]] && ! [[ "$*" =~ --colou?rs? ]]; then
    ble/fd#alloc _ble_util_fd_cmd_stdout ">/tmp/blesh-stdout" overwrite
    ble/fd#alloc _ble_util_fd_cmd_stderr ">&$_ble_util_fd_cmd_stdout" overwrite
    ble/fd#add-cloexec "$_ble_util_fd_cmd_stdout"
    ble/fd#add-cloexec "$_ble_util_fd_cmd_stderr"
  fi

  #if [[ -z $_ble_util_fd_cmd_stdout ]]; then
  #  ble/fd#alloc _ble_util_fd_cmd_stdout ">/tmp/blesh-stdout" overwrite
  #fi
  #tty=$(tty)
  #( (
  #  sleep 0.3                         # approx. time needed for pts allocation, delays TUI apps by this time
  #  pts_after=$(ps -t "$tty" | wc -l) # FIX: every command creates entry in pts
  #  #pts_after=$(stty -a | grep '\-icanon')
  #  if [[ $pts_after -gt $((pts_before + 1)) ]]; then
  #    # creates stdout for new application
  #    ble/fd#alloc _ble_util_fd_cmd_stdout ">/dev/tty" overwrite
  #    ble/fd#alloc _ble_util_fd_cmd_stderr ">&$_ble_util_fd_cmd_stdout" overwrite
  #    ble/fd#add-cloexec "$_ble_util_fd_cmd_stdout"
  #    ble/fd#add-cloexec "$_ble_util_fd_cmd_stderr"
  #  fi
  #) &)
  #ble/fd#alloc _ble_util_fd_cmd_stderr ">&$_ble_util_fd_cmd_stdout" overwrite
  #ble/fd#add-cloexec "$_ble_util_fd_cmd_stdout"
  #ble/fd#add-cloexec "$_ble_util_fd_cmd_stderr"
}

precmd() {
  :
}

postexec() {
  # $ script -qeO /tmp/blesh-stdout -c "ls -la aroise"
  # $ cat foo.c|highlight --syntax c --out-format=truecolor
  #if [[ -e /tmp/blesh-stdout ]]; then
  #  content_type=$(file -b /tmp/blesh-stdout | cut -f1 -d' ')
  #  content_type=${content_type:-empty}
  #fi

  #if [[ "$*" =~ --help|help|-h ]]; then
  #  bat -pplhelp /tmp/blesh-stdout
  #elif [[ "$content_type" != "empty" ]]; then
  #  language=$(BAT_PAGER='' bat --list-languages | grep -i -m1 "$content_type" | cut -f1 -d':')
  #  # if not exact match then longest
  #  #BAT_PAGER='' bat --list-languages | grep -i --color -o -E "B?o?u?r?n?e?-?A?g?a?i?n?" | awk '{print length " " $0}'| sort -n | tail -1
  #  #language=$(BAT_PAGER='' bat --list-languages | grep -i -m1 -e "$content_type" -e "\[$content_type\]" | cut -f1 -d':')
  #  bat -ppl"${language:-Plain Text}" /tmp/blesh-stdout
  #fi
  if [[ "$*" =~ --help|"help "|" -h" ]] && ! [[ "$*" =~ --colou?rs? ]]; then
    bat -pplhelp /tmp/blesh-stdout
    ble/fd#alloc _ble_util_fd_cmd_stdout '>/dev/tty' overwrite
    ble/fd#alloc _ble_util_fd_cmd_stderr ">&$_ble_util_fd_cmd_stdout" overwrite
    ble/fd#add-cloexec "$_ble_util_fd_cmd_stdout"
    ble/fd#add-cloexec "$_ble_util_fd_cmd_stderr"
    rm -f /tmp/blesh-stdout
  fi
}

if [[ ${BLE_VERSION-} ]]; then
  #source "$_ble_base/lib/vim-surround.sh"

  #bleopt canvas_winch_action=redraw-prev

  ble-import contrib/colorglass
  #ble-import contrib/histdb
  ble-import contrib/integration/bash-completion
  #ble-import contrib/airline/*
  ble-import -f integration/zoxide
  #ble-import integration/bash-preexec

  blehook POSTEXEC!=postexec
  #blehook ATTACH=
  #blehook DETACH=
  #blehook PREEXEC=
  #blehook PRECMD=
  #blehook POSTEXEC=

  #bleopt term_true_colors=
  #bleopt colorglass_gamma=-50
  #bleopt colorglass_contrast=70
  #bleopt colorglass_brightness=-10

  #bleopt line_limit_type=editor
  #bleopt line_limit_length=1000
  #bleopt history_limit_length=1000
  bleopt exec_elapsed_enabled='usr+sys'
  #bleopt history_default_point=preserve
  # SPEED Enhancers these are defaults if commented
  bleopt history_erasedups_limit=100
  bleopt highlight_timeout_async=3000
  #bleopt highlight_timeout_sync=50
  #bleopt highlight_eval_word_limit=200
  #bleopt complete_limit_auto=2000
  #bleopt complete_limit_auto_menu=100
  bleopt complete_timeout_auto=3000
  #bleopt complete_timeout_compvar=200
  #bleopt complete_polling_cycle=50

  # turn off history completion till ble.sh isn't fixed
  bleopt complete_auto_history=
  bleopt history_share=1
  #bleopt complete_ambiguous=1
  # turn off if typing hangs
  #bleopt complete_auto_complete=
  function blerc/disable-progcomp-for-auto-complete.advice {
    if [[ $BLE_ATTACHED && :$comp_type: == *:auto:* ]]; then
      return 0
    fi
    ble/function#advice/do
  }
  ble-import core-complete -C '
    # <func> or <cmd>
    ble/function#advice around _man blerc/disable-progcomp-for-auto-complete.advice
    ble/function#advice around man blerc/disable-progcomp-for-auto-complete.advice
    ble/function#advice around pacman blerc/disable-progcomp-for-auto-complete.advice
    ble/function#advice around systemctl blerc/disable-progcomp-for-auto-complete.advice
  '

  ## we could bind this to enter
  function ble/widget/daru/nnn_complete() {
    ble/widget/vi_nmap/copy-current-line
    readline_line="${_ble_edit_kill_ring[0]}"
    ble/widget/kill-line

    if echo "$readline_line" | grep "%j" >/dev/null; then
      ble/widget/insert-string "cat ${NNN_SEL:-${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.selection} | xargs -0 -I%j sh -c \"$readline_line\""
    elif echo "$readline_line" | grep "%J" >/dev/null; then
      #elif echo "$READLINE_LINE" | grep -E "(?<!\\)%J"; then
      readline_line=$(echo "$readline_line" | sed 's/%J//')
      ble/widget/insert-string "cat ${NNN_SEL:-${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.selection} | xargs -0 $readline_line"
    else
      ble/widget/insert-string "$readline_line"
      ## or comment this out and don't bind it to enter
      # echo '%j %J not specified, aborting'
    fi
    unset readline_line
    ble/widget/accept-line
  }

  function ble/widget/daru/copy_readline() {
    ble/widget/vi-command/operator y
    ble/widget/vi-command/operator y
    if [ "$XDG_SESSION_TYPE" = x11 ]; then
      ble/util/put "${_ble_edit_kill_ring[0]}" | xsel -bi
    else
      ble/util/put "${_ble_edit_kill_ring[0]}" | wl-copy
    fi
  }

  function ble/widget/daru/copy_readline_end() {
    ble/widget/vi_nmap/blockwise-visual-mode
    ble/widget/vi-command/forward-eol
    ble/widget/vi-command/operator y
    if [ $XDG_SESSION_TYPE = x11 ]; then
      ble/util/put "${_ble_edit_kill_ring[0]}" | xsel -bi
    else
      ble/util/put "${_ble_edit_kill_ring[0]}" | wl-copy
    fi
  }

  ble-bind -m vi_nmap -f Y daru/copy_readline_end
  ble-bind -m vi_nmap -f y daru/copy_readline
  ble-bind -m vi_nmap -f 'C-/ C-n' daru/nnn_complete
  ble-bind -m vi_imap -f 'C-/ C-n' daru/nnn_complete
  ble-bind -m vi_imap -f C-e edit-and-execute-command

  ble-bind -m vi_nmap -f 'g g' vi-command/first-nol
  ble-bind -m vi_omap -f 'g g' vi-command/first-nol
  ble-bind -m vi_xmap -f 'g g' vi-command/first-nol
  ble-bind -m vi_nmap -f 'G' vi-command/last-line
  ble-bind -m vi_omap -f 'G' vi-command/last-line
  ble-bind -m vi_xmap -f 'G' vi-command/last-line

  ble-bind -m vi_nmap -c 'g s' 'git status'
  ble-bind -m vi_nmap -c '; n' 'nn'
  #ble-bind -m vi_nmap -c '; h' 'h'
  ble-bind -m vi_nmap -c 'C-[' 'exit'
  ble-bind -m vi_imap -c 'C-[' 'exit'
  ble-bind -m vi_xmap -c 'C-[' 'exit'
  ble-bind -m vi_cmap -c 'C-[' 'exit'
  ble-bind -m vi_omap -c 'C-[' 'exit'
  ble-bind -m menu_complete -f '__default__' menu_complete/cancel
  #source "$XDG_CONFIG_HOME/bash/colemak"

  #ble-bind -x C-r _fzf_history_for_blesh
  #_fzf_history_for_blesh() {
  #  READLINE_LINE=$(history | fzf --scheme=history --tac)
  #  #READLINE_LINE=$(history|tac|sed -e 's/^ [0-9]\+  \+//'|fzf --scheme=history)
  #  READLINE_POINT=${#READLINE_LINE}
  #}
  #

  ble-attach
  #ble/debug/profiler/stop
fi
