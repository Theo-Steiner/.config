if status is-interactive
  fish_vi_key_bindings
  # allow special cursors for vi modes
  set -g fish_vi_force_cursor 1
  set fish_cursor_default block
  set fish_cursor_insert line

  for mode in insert default visual
    # search up and down with <C-P> / <C-N>
    bind -M $mode \cp up-or-search
    bind -M $mode \cn down-or-search
    # complete with <C-F>
    bind -M $mode \cf forward-char
  end
end

export EDITOR='nvim'
export VISUAL='nvim'

# alias nvim to vi
function vi
  nvim $argv
end

function vic
  cd ~/.config && vi
end

function fish_greeting
  echo User: (set_color blue; echo Theo-Steiner; set_color normal)
  echo Time: (set_color yellow; date +%T; set_color normal)
  echo Device: (set_color purple; echo $hostname; set_color normal)
end
