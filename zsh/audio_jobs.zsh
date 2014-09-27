#! /bin/zsh
# commands used by me to convert audio

function alac2flac() {
    find -iname '*.m4a' | parallel --no-notice --eta 'alac {} | flac -o {.}.flac - && rm {}'
}

function flac2ogg() {
    find -iname '*.flac' | parallel --no-notice --eta 'oggenc --quality=6.66 {} && rm -v {}'
    collectiongain .
}

function alac2ogg() {
    find -iname '*.m4a' | parallel --no-notice --eta 'alac {} | oggenc --quality=6.66 -o {.}.ogg - && rm {}'
}
