#!/bin/bash

# dependencies: emacs, transcoding suite

# $1 is text file or directory
# $2 is the emacs transcoding command without "transcode_"

tsloc="$HOME/git/transcoding-suite/transcoding-suite.el"
command="transcode_${2}"
ext="_${2/*-/}"

transcode(){
    nfn="${1%.*}${ext}.${1/*./}"
    echo "transcoding ${1}..."
    emacs -batch -Q \
	  --load="${tsloc}" \
	  --file="${1}" \
	  --funcall="mark-whole-buffer" \
	  --funcall="${command}" \
	  --eval="(write-file \"${nfn}\")" > /dev/null
    echo "wrote ${nfn}."
}


#if file
[ -f "${1}" ] && transcode "${1}";

#if dir
[ -d "${1}" ] && for f in "${1}"/*; do transcode "${f}"; done;

exit
