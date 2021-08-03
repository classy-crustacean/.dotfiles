# ~/.config/fish/config.fish
set -U fish_greeting
/usr/local/bin/starship init fish | source
ssh-agent -s > /dev/null 2>&1
set EDITOR /usr/bin/vim
if test (uname) = "Linux"
	alias copy="xsel -ib"
else if test (uname) = "Darwin"
	alias copy="pbcopy"
end
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias la='ls -@Ah'
