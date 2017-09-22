# /usr/bin/bash

#saving current clipboard content
PREV_CLIPBOARD_VALUE=$(xclip -out -selection clipboard)

xclip -out -selection primary | xclip -in -selection clipboard
selectedtext=$(xclip -out -selection clipboard)
google-chrome-stable  https://www.diki.pl/slownik-angielskiego?q=$selectedtext
google-chrome-stable  http://www.dictionary.com/browse/$selectedtext

echo PREV_CLIPBOARD_VALUE | xclip -sel clip 
