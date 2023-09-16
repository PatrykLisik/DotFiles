#bin/sh
scrot -s  $HOME/Pictures/Screenshot_%Y-%m-%d_%H.%M.%S.png -e 'xclip -selection clipboard -t image/png -i $f'

