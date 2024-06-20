#!/bin/sh

filename=$1

# if filename doesn't exist, create it and then compile with pandoc
if ! test -f ./${filename}.md; then
    echo '#' > ./${filename}.md
    pandoc -t latex ${filename}.md -o ${filename}.pdf
fi

# Open the pdf in evince and open a new terminal with nvim to edit the file.
/bin/evince ${filename}.pdf & > /tmp/evincecomplaints
(/bin/urxvt -e /bin/nvim ${filename}.md) &

# For every change in the markdown file, compile again.
(find . -name ${filename}.md | entr pandoc -t latex ${filename}.md -o ${filename}.pdf > /tmp/kk) &
disown
