#! /bin/zsh

# Find all ALAC files and convert them to flac.
alac2flac() {
    find -iname '*.m4a' | parallel --no-notice --progress 'alac {} | flac -o {.}.flac - && rm {}'
}

# Find all FLAC files and convert them to ogg.
flac2ogg() {
    find -iname '*.flac' | parallel --no-notice --progress 'oggenc --quality=6.66 {} && rm -v {}'
    collectiongain .
}

# Find all ALAC files and convert them to Vorbis
alac2ogg() {
    find -iname '*.m4a' | parallel --no-notice --progress 'alac {} | oggenc --quality=6.66 -o {.}.ogg - && rm {}'
}

#
createHelper() {
    readonly output="$1"

    # If file exists, then do nothing
    test -x $output && exit

    echo '#!/bin/zsh' >! $output
    echo 'readonly tagfile="$1"' >> $output
    echo 'shift' >> $output
    echo 'readonly wavfile="$1"' >> $output
    echo 'shift' >> $output
    echo 'readonly mp3file="$1"' >> $output
    echo 'shift' >> $output

    echo "readonly title=\"\$(grep ^TITLE= \$tagfile | sed -e 's/^.*=//')\"" >> $output
    echo "readonly artist=\"\$(grep ^ARTIST= \$tagfile | sed -e 's/^.*=//')\"" >> $output
    echo "readonly album=\"\$(grep ^ALBUM= \$tagfile | sed -e 's/^.*=//')\"" >> $output
    echo "readonly year=\"\$(grep ^DATE= \$tagfile | sed -e 's/^.*=\(....\).*$/\1/')\"" >> $output
    echo "readonly track=\"\$(grep ^TRACKNUMBER= \$tagfile | sed -e 's/^.*=//')/\$(grep ^TRACKTOTAL= \$tagfile | sed -e 's/^.*=//')\"" >> $output

    echo 'lame -q0 --noreplaygain --id3v2-only --ignore-tag-errors $@ --tt "$title" --ta "$artist" --tl "$album" --ty "$year" --tn "$track" $wavfile $mp3file' >> $output
    echo 'rm $tagfile' >> $output

    chmod +x $output
}

prepare_for_what() {
    readonly target_directory="$1"
    test -d /tmp/wavs/$target_directory && exit
    mkdir -p /tmp/wavs/$target_directory

    find $target_directory -iname '*.flac' | parallel --no-notice --progress 'flac --decode --output-prefix=/tmp/wavs/'
    find $target_directory -iname '*.flac' | parallel --no-notice 'metaflac --export-tags-to=/tmp/wavs/{.}.tags {}'
}

flac_320() {
    createHelper /tmp/wavs/helper
    readonly input_directory="$1"

    readonly output_directory="$input_directory (320)"
    mkdir -p $output_directory

    test -e $input_directory/folder.png && cp $input_directory/folder.png $output_directory/

    cd $output_directory
    find /tmp/wavs/$input_directory -iname '*.tags' | parallel --no-notice -X 'cp {} .'

    find -iname '*.tags' | parallel --no-notice --progress /tmp/wavs/helper {} /tmp/wavs/{.}.wav {.}.mp3 --cbr -b 320

    collectiongain .
    popd
}

flac_V0() {
    createHelper /tmp/wavs/helper
    readonly input_directory="$1"

    readonly output_directory="$input_directory (320)"
    mkdir -p $output_directory

    test -e $input_directory/folder.png && cp $input_directory/folder.png $output_directory/

    cd $output_directory
    find /tmp/wavs/$input_directory -iname '*.tags' | parallel --no-notice -X 'cp {} .'

    find -iname '*.tags' | parallel --no-notice --progress /tmp/wavs/helper {} /tmp/wavs/{.}.wav {.}.mp3 --vbr-new -V0

    collectiongain .
    popd
}

flac_V2() {
    createHelper /tmp/wavs/helper
    readonly input_directory="$1"

    readonly output_directory="$input_directory (320)"
    mkdir -p $output_directory

    test -e $input_directory/folder.png && cp $input_directory/folder.png $output_directory/

    cd $output_directory
    find /tmp/wavs/$input_directory -iname '*.tags' | parallel --no-notice -X 'cp {} .'

    find -iname '*.tags' | parallel --no-notice --progress /tmp/wavs/helper {} /tmp/wavs/{.}.wav {.}.mp3 --vbr-new -V2

    collectiongain .
    popd
}

