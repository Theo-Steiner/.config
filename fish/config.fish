if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    fish_vi_key_bindings
	for mode in insert default visual
		bind -M $mode \cp up-or-search
		bind -M $mode \cn down-or-search
		bind -M $mode \cf forward-char
	end
end

export EDITOR='nvim'

function vi
	nvim $argv
end

function vic
	cd ~/.config/nvim && vi init.lua
end
