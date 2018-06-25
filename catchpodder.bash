#!/bin/bash
# By Linc 10/1/2004
# Find the latest script at http://lincgeek.org/bashpodder
# Revision 1.21 12/04/2008 - Many Contributers!
# If you use this and have made improvements or have comments
# drop me an email at linc dot fessenden at gmail dot com
# and post your changes to the forum at http://lincgeek.org/lincware
# I'd appreciate it!
# ------------------------------------------------------------------
# modified by ellen taylor (ellencubed at gmail dot com)
# modified by trevor davis (trevor.l.davis at gmail dot com) 2013
#--------------------------------------------------------------------
# modified by tomasz jadowski (jadowski at protonmail dot com) 2016-2018
#--------------------------------------------------------------------
# LICENSE
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
#--------------------------------------------------------------------


datadir=$(pwd)
metadir=$datadir/.catchpodder
podcastlog=$metadir/podcasts.log
feed=$metadir/feed
program="CatchPodder v0.1.0 (https://github.com/tjadowski/catchpodder.git)"
timeout=30
retry=10

function main {
    case $1 in
        "download")
            download new.log
            # Move dynamically created log file to permanent log file:
            cat $metadir/new.log > temp.log
            cat $podcastlog >> temp.log
            sort temp.log | uniq > $podcastlog
            rm temp.log
            ;;
        "sync")
            sync
            ;;
        "init")
            init $2
            ;;
        "itunes")
            itunes $2      
            ;;
        "help" | "usage" | *)
            usage;;
    esac
}

function usage {
    echo $program
    echo
    echo "Usage: catchpodder init | sync | download | help"
    echo "                                                "
    echo "     init <url> - init with podcast RSS feed"
    echo "     sync - sync podcast RSS feed"
    echo "     itunes <id> - init via iTunes podcast ID"
    echo "     download - download new or incomplete files"
    echo "                                                "
}

function itunes {
  init https://pcr.apple.com/id$1
}

function downloader {
    url=$1
    output=$2

    wget -T $timeout -q -c -t $retry -U "$program" -O $output $url
}

function init {
    url=$1

    if [ -d $metadir ]; then
        rm -rf $metadir
    fi
    mkdir -p $metadir
    echo "$url" > $metadir/url
    touch $podcastlog
    touch $feed
}

function sync {
    url=`cat $metadir/url`

    rm -f $feed
    echo "Start syncing feed from $url"
    downloader $url $feed
}

function download {
    logfile=$metadir/$1

    # Delete any temp file:
    if [ -f $logfile ]; then
        rm -f $logfile
    fi
    touch $logfile


    # Read the feed
    cd $(dirname $0)
    file=$(xsltproc parse_url.xsl $feed 2> /dev/null)
    for url in $file
        do
            filename=$(echo "$url" | awk -F'/' {'print $NF'} | awk -F'?' {'print $1'})
            if ! grep "$filename" $podcastlog > /dev/null ; then
                echo $filename >> $logfile
                echo "Download $url"
                downloader $url $datadir/$filename
            fi
        done
}

main $@
