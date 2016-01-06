#!/bin/bash

# AUTHOR: Konrad Twardowski
# LICENSE: http://en.wikipedia.org/wiki/WTFPL

# NOTE: To customize text and event handlers,
#       edit the "menu-config.sh" file.

# text
titleText="$0 v1.0.1"
listText="Items"
okText="OK"
editText="Customize..."
quitText="Quit"

# apps
#textEditor=mcedit
textEditor=sensible-editor

keyFile=$(mktemp --suffix=key)
key=
value=
text=

# include config and data
dataFile="$(dirname $0)/$(basename "$0" .sh)-config.sh"
source "$dataFile"

# called on script exit
function onClose()
{
	clear
	rm -f "$keyFile"
	exit 0
}

# called on file edit
function onEdit() {
	"$textEditor" "$dataFile"
	# reload
	source "$dataFile"
}

# main loop
while [ 1 ]; do

# show TUI
dialog \
	--backtitle "$titleText"  \
	--title "$listText" \
	\
	--ok-label "$okText" \
	--extra-button \
	--extra-label "$editText" \
	--cancel-button "$quitText" \
	\
	--default-item "$key" \
	--item-help \
	--no-lines \
	--no-shadow \
	--scrollbar \
	\
	--menu "" 0 0 0 \
	"${items[@]}" \
	\
	2> "$keyFile"

dialogExitCode=$?
key=$(cat "$keyFile")

index=0
for i in "${items[@]}"; do
	index=$(($index+1))
	if [ "$i" == "$key" ]; then
		value="${items[$index]}"
		text="${items[$index+1]}"
		break;
	fi
done # for

case "$dialogExitCode" in
	0) onAction;;
	3) onEdit;;
	*) onClose;;
esac

done # while
