mkdir -p ~/.gitbar/bin
cp -f gitbar.sh ~/.gitbar/gitbar.sh

[ ! -f ~/.gitbar/bin/paths ] && gcc paths.c -o ~/.gitbar/bin/paths
[ ! -f ~/.gitbar/bin/rep ] && gcc rep.c -o ~/.gitbar/bin/rep

chmod 550 ~/.gitbar/bin/{paths,rep}

if ! egrep -q '^PATH=.*\$HOME/\.gitbar/bin.*$' ~/.zshrc; then
	echo 'PATH="$PATH:$HOME/.gitbar/bin"' >> ~/.zshrc
fi
