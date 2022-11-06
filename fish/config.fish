if status is-interactive
    # Commands to run in interactive sessions can go here
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

function fish_greeting
	echo User: (set_color blue; echo Theo-Steiner; set_color normal)
    echo Time: (set_color yellow; date +%T; set_color normal)
	echo Device: (set_color purple; echo $hostname; set_color normal)
end


