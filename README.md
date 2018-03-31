# CatchPodder

CatchPodder is a simple bash command-line tool based on concept of other similar
tools like [bashpodder](http://lincgeek.org/bashpodder) and
[catch](https://github.com/duffey/catch) tool \(written in C and follow the
[suckless](http://suckless.org) philosophy. It's need an external libraries like
curl and xml, but I like it flows except lacks of continued downloads which
isn't acceptable for me. I've tried to modify source, but C language is
overengineering for this task in my opinion\).

CatchPodder need xsltproc package and the standard Unix command-line tools.

CODE:

- [https://github.com/tjadowski/catchpodder.git](https://github.com/tjadowski/catchpodder.git)

CONTRIBUTING

Patches are welcome. Please use patch command and send it (them) to [jadowski@protonmail.com](mailto:jadowski@protonmail.com).

ISSUES:

- please update BUGS and TODO section of this README

TODO:

- CatchPodd#01: [Fixed] support for [iTunes podcast link](http://superuser.com/questions/78415/get-rss-feed-from-itunes-podcast-links)
- CatchPodd#02: [Won't Fix] add parallel support for downloads
- CatchPodd#03: add debug and override wget parameters options

BUGS:

CHANGELOG:

- 03/30/2018: Import from old repo
- 01/15/2017: Resolved CatchPodd#01

LICENSE:

 Copying and distribution of this file, with or without modification,
 are permitted in any medium without royalty provided the copyright
 notice and this notice are preserved.  This file is offered as-is,
 without any warranty.
