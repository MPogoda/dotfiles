#! /bin/zsh
# commands used by me to convert audio

function alac2flac() {
    for alac in *.m4a
    do
        alac $alac | flac -o "$(echo $alac | sed -e 's/m4a$/flac/')" -
        rm -v $alac
    done
}

function flac2ogg() {
    oggenc --quality=6.66 *.flac && rm -v *.flac && vorbisgain --album *.ogg
}
