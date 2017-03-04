ps1_git() {
	st="`git status`"

	echo $st | grep -q "Not a git repo" && return;

	echo "\e[1m$(rep 80 _)\e[0m"

	branch=`echo $st | grep 'On branch' | sed -E 's/On branch (.*)$/\1/'`

	if [ -z "$branch" ]; then
		tmp=`echo $st | grep 'HEAD detached at' | sed -E 's/^HEAD detached at (.*)$/\1/'`
		[ "$tmp" ] && branch=\#$tmp || branch='\e[D'
	fi
	echo -n "\e[1m|\e[0m \e[1;96m⎇  \e[0;96m$branch\e[0m"



	ahead=`echo $st | grep 'ahead of' | sed -E "s:^Your branch is ahead of '[^']+' by ([0-9]+) commits?.:\1:"`

	if [ "$ahead" ]; then
		echo -n " \e[1m|\e[0m \e[91m⇪ $ahead ahead\e[0m"
	elif ! echo $st | head -n 2 | grep -q 'Your branch is up-to-date'; then
		echo -n " \e[1m|\e[0m \e[93m⇪ none\e[0m"
	else
		echo -n " \e[1m|\e[0m \e[92m⇪ latest\e[0m"
	fi

	if echo $st | egrep -q '^Changes .*commit.*'; then
		added=`echo $st | grep -c 'new file:'`
		modded=`echo $st | grep -c 'modified:'`
		deleted=`echo $st | grep -c 'deleted:'`

		echo -n " \e[1m|\e[0m \e[93m⇏ stage\e[0m"
		[ $added -gt 0 ] && echo -n " \e[92m+$added\e[0m"
		[ $modded -gt 0 ] && echo -n " \e[93m±$modded\e[0m"
		[ $deleted -gt 0 ] && echo -n " \e[91m-$deleted\e[0m"
	else
		echo -n " \e[1m|\e[0m \e[92m⇒ stage\e[0m"
	fi

	if echo $st | grep -q 'Untracked files:'; then
		untracked=`git status | egrep -v '^\t(added:|modified|new file:)' | egrep -c '^\t'`
		echo -n " \e[1m|\e[0m \e[93m◎ $untracked untracked\e[0m "
	else
		echo -n " \e[1m|\e[0m \e[92m◉ track\e[0m "
	fi

	echo "\e[F\e[E`rep 79 $(echo "\e[C")`\e[1m|\e[0m"
}

precmd() {
	do_git=''
	for d in $(paths $PWD); do
		if [ -d "$d/.git" ] && git status | grep -qv "Not a git repo"; then
			do_git=1
			break
		fi
	done

	[ "$do_git" ] && ps1_git
}
