hud_git() {
	st=`git status --porcelain --branch`

	branch=''; commit=''; stage=''; track=''

	branch=`echo $st | egrep '^##' | cut -d ' ' -f 2- | cut -d . -f 1`
	if [ "$branch" '==' 'HEAD (no branch)' ]; then
		branch='detachedm'
	fi

	branch=`echo $branch |\
		sed "s/Initial commit on /$(echo -en '[I] ')/"`

	behead=`git rev-list --left-right --count @{u}.. 2>&1`
	behind=`echo $behead | cut -f 1`
	ahead=`echo $behead | cut -f 2`

	if echo $behead | egrep -q ^fatal; then
		commit='none'
	elif [ "$ahead" -gt 0 -o "$behind" -gt 0 ]; then
		[ "$behind" -gt 0 ] && commit="behind $behind"
		[ "$ahead" -gt 0 ] && commit+="ahead $ahead"
	fi

	if [ "$commit" '==' 'none' ]; then
		commit="⇪ none"
	elif [ $commit ]; then
		commit="⇪ $commit"
	else
		commit="⇪ latest"
	fi

	stage_a=`echo $st | egrep -c '^A '`
	stage_d=`echo $st | egrep -c '^ D'`
	stage_m=`echo $st | egrep -c '^ M'`
	stage_r=`echo $st | egrep -c '^R '`

	[ "$stage_a" -gt 0 ] && stage+=" +$stage_a"
	[ "$stage_m" -gt 0 ] && stage+=" ±$stage_m"
	[ "$stage_d" -gt 0 ] && stage+=" -$stage_d"
	[ "$stage_r" -gt 0 ] && stage+=" =$stage_r"

	if [ $stage ]; then
		stage="⇏ stage$stage"
	else
		stage="⇒ stage"
	fi

	track=`echo $st | egrep -c '^\?\?'`
	if [ "$track" -gt 0 ]; then
		track="◎ $track untracked"
	else
		track="◉ trackm"
	fi

	hud="$branch"
	hud+=" $commit $stage $track"

	echo "]2;$hud"
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
