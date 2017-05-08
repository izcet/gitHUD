mkdir -p ~/.gitHUD/bin
cp -f githud.sh ~/.gitHUD/githud.sh

[ ! -f ~/.gitHUD/bin/paths ] && gcc paths.c -o ~/.gitHUD/bin/paths

chmod 550 ~/.gitHUD/bin/paths

if ! egrep -q '^. ~/.gitHUD/githud.sh$' ~/.zshrc; then
	echo '. ~/.gitHUD/githud.sh' >> ~/.zshrc
fi

if ! egrep -q '^PATH=.*\$HOME/\.gitHUD/bin.*$' ~/.zshrc; then
	echo 'PATH="$PATH:$HOME/.gitHUD/bin"' >> ~/.zshrc
fi

source ~/.zshrc
