#! /bin/zsh
# commands used by me to convert audio

function alac2flac() {
    set -e
    for alac in *.m4a
    do
        alac $alac | flac -o "$(echo $alac | sed -e 's/m4a$/flac/')" -
        rm -v $alac
    done
}

function flac2ogg() {
    set -e
    oggenc --quality=6.66 *.flac
    rm -v *.flac
    collectiongain .
}

function alac2ogg() {
    set -e
    for alac in *.m4a
    do
        alac $alac | oggenc --quality=6.66 -o "$(echo $alac | sed -e 's/m4a$/ogg/')" -
        rm -v $alac
    done

    collectiongain .
}
