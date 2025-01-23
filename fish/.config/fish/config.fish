if status is-interactive
	# Commands to run in interactive sessions can go here
	set fish_greeting
	fastfetch
	source (/usr/bin/starship init fish --print-full-init | psub)
end
