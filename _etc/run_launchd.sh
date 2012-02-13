if [[ -s ~/.rvm/scripts/rvm ]]; then
        . ~/.rvm/scripts/rvm
fi
. .rvmrc
/Users/csexton/.rvm/gems/ruby-1.9.2-p136@codeography/bin/jekyll && /usr/local/bin/growlnotify -i txt -m "New build of codeography.com" "Jekyll" || /usr/local/bin/growlnotify -i txt -m "Failed to build codeography.com" "Jekyll"
