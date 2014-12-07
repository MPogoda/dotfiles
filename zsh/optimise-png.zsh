#! /bin/zsh

function optpng() {
    find -iname '*.png' | nice parallel --no-notice --progress\
        'optipng -o7 -preserve -f0-5 -zc1-9 -zm1-9 -zs0-3'
}

