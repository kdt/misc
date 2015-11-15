
# EXAMPLE: customized text
titleText="Radio"
listText="Playlist"
okText="Play!"

# EXAMPLE:
# called on Enter press
# $key, $value and $text are extracted from the selected item
function onAction()
{
	clear

	echo
	echo "Playing $key <$value>..."
	echo "$text"
	echo
	echo "Press \"Ctrl+C\" to stop"
	echo

	cvlc --play-and-exit "$value"
}

# FORMAT:
#
# "Unique Key 1"
# "Any Value 1"
# "Any Text 1"
#
# "Unique Key n"
# "Any Value n"
# "Any Text n"
#
# EXAMPLE:
items=(

"Electro Swing"
"http://www.di.fm/mp3/electroswing.pls"
""

"Goa-Psy Trance"
"http://www.di.fm/mp3/goapsy.pls"
"...a voyage out of this world!"

)
