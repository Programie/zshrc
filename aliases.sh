if [ "`uname`" = "Darwin" ]; then
	alias ll='ls -lh' # Same as 'ls' but also show permissions, readable file sizes and more
	alias l='ls -lhA' # Same as 'll' but also show items starting with a dot
	alias lm='ls -lhA | more' # Same as 'l' but pipe it through 'more' to scroll the list
else
	alias ls='ls --color=auto' # Normal ls with colored items
	alias ll='ls --color=auto -lh' # Same as 'ls' but also show permissions, readable file sizes and more
	alias l='ls --color=auto -lhA' # Same as 'll' but also show items starting with a dot
	alias lm='ls --color=auto -lhA | more' # Same as 'l' but pipe it through 'more' to scroll the list
fi

alias iftop='sudo iftop' # Always start 'iftop' as root (Required by this command)
alias root='sudo $SHELL' # Start zsh as root
alias df='df -h' # Show Filesystem information in human readable format
alias fs='du -sch *' # Show the disk usage of the folders in the current directory
alias ports='netstat -tulanp' # Show open ports
alias lmnt='mount | column -t' # Show mounted devices in a pretty and human readable format
alias ,='popd' # Shortcut to switch to previous directory

# Check if the local svn working copy is up to date without updating
checksvn()
{
	if [ "$1" ]; then
		HEAD=`svn info -r HEAD $1 | sed -nr 's/Last Changed Rev: ([0-9]+)/\1/p'`
		CURRENT=`svn info $1 | sed -nr 's/Last Changed Rev: ([0-9]+)/\1/p'`
		if [ "$HEAD" = "$CURRENT" ]; then
			echo "OK"
		else
			URL="`svn info $1 | sed -nr 's/URL: (.*)/\1/p'`"
			AUTHOR="`svn info $URL | sed -nr 's/Last Changed Author: (.*)/\1/p'`"
			echo "$HEAD ($AUTHOR)"
		fi
	else
		echo "Usage: $0 Path"
	fi
}


# Check Apache configuration and restart Apache if syntax is correct
restartapache()
{
	apache2ctl configtest
	if [ "$?" = "0" ]; then
		apache2ctl restart
		if [ "$?" = "0" ]; then
			echo "Apache restart successful"
		else
			echo "Apache restart FAILED!"
		fi
	else
		echo "Apache configuration test FAILED!"
	fi
}


# Update all packages
update()
{
	sudo aptitude update
	sudo aptitude full-upgrade
}
