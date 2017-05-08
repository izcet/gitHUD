hud_git() {
	st=`git status --porcelain --branch`

	branch=''; commit=''; stage=''; track=''

	branch=`echo $st | egrep '^##' | cut -d ' ' -f 2- | cut -d . -f 1`
	if [ "$branch" '==' 'HEAD (no branch)' ]; then
		branch='\e[91mdetached\e[0m'
	fi

	branch=`echo $branch |\
		sed "s/Initial commit on /$(echo -en '\e[0m[\e[96mI\e[0m]\e[96m ')/"`

	behead=`git rev-list --left-right --count @{u}.. 2>&1`
	behind=`echo $behead | cut -f 1`
	ahead=`echo $behead | cut -f 2`

	if echo $behead | egrep -q ^fatal; then
		commit='none'
	elif [ "$ahead" -gt 0 -o "$behind" -gt 0 ]; then
		[ "$behind" -gt 0 ] && commit="<$behind"
		[ "$ahead" -gt 0 ] && commit+=">$ahead"
	fi

	if [ "$commit" '==' 'none' ]; then
		commit="\e[93m⇪ none\e[0m"
	elif [ $commit ]; then
		commit="\e[91m⇪ $commit\e[0m"
	else
		commit="\e[92m⇪ latest\e[0m"
	fi

	stage_a=`echo $st | egrep -c '^A '`
	stage_d=`echo $st | egrep -c '^ D'`
	stage_m=`echo $st | egrep -c '^ M'`
	stage_r=`echo $st | egrep -c '^R '`

	[ "$stage_a" -gt 0 ] && stage+=" \e[92m+$stage_a\e[0m"
	[ "$stage_m" -gt 0 ] && stage+=" \e[93m±$stage_m\e[0m"
	[ "$stage_d" -gt 0 ] && stage+=" \e[91m-$stage_d\e[0m"
	[ "$stage_r" -gt 0 ] && stage+=" =$stage_r"

	if [ $stage ]; then
		stage="\e[93m⇏ stage$stage\e[0m"
	else
		stage="\e[92m⇒ stage\e[0m"
	fi

	track=`echo $st | egrep -c '^\?\?'`
	if [ "$track" -gt 0 ]; then
		track="\e[93m◎ $track untracked\e[0m"
	else
		track="\e[92m◉ track\e[0m"
	fi

	hud="\e[1m|\e[0m \e[1;96m⎇  \e[0;96m$branch\e[0m"
	hud+=" \e[1m|\e[0m $commit \e[1m|\e[0m $stage \e[1m|\e[0m $track"

	echo $hud
}

precmd() {
	do_git=''
	for d in $(paths $PWD); do
		if [ -d "$d/.git" ] && git status | grep -qv "Not a git repo"; then
			do_git=1
			break
		fi
	done

	[ "$do_git" ] && hud_git
}
