#!/bin/bash
function _start-with-proxy() {
	export SOCKS_SERVER=127.0.0.1:1080
        export SOCKS_VERSION=5
        google-chrome-stable %U --user-data-dir="/home/[USER]/.chromium profiles/[PROFILEDIR]"
}
_start-with-proxy
