#!/bin/bash

cdup() {
	p=${1}
	if [[ $p = -* ]]; then
		c="cd "
		while [[ $p -lt 0 ]]; do
			c=$c"../"
			let p=p+1
		done
		$c
	else
		a=$(pwd)
		#remove current dir
		b=${a%/*}
		#build cd
		c="cd "${b%$1*}$1
		$c
	fi
}

_cdup_complete() {
	local cur prev path ar
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	path=$(pwd)
	old_ifs=$IFS
	IFS=/
	ar=$path
	COMPREPLY=( $(compgen -W "${ar}" ${cur}) )
	IFS=$old_ifs
	return 0
}

complete -F _cdup_complete cdup

