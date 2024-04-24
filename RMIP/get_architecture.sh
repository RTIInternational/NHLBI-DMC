#!/usr/bin/env sh

{ # Provide the usage # 

# Ensure that all variables are explicitly defined
set -u 

SB_UPDATE_ROOT="https://igor.sbgenomics.com/downloads/sb"

usage() {
    cat 1>&2 <<EOF
get_architecture.sh
Determine whether the system is 32 or 64 bit and the type of processor 

USAGE:
    get_architecture.sh [FLAGS]

FLAGS:
    -v, --verbose               Enable verbose output
    -h, --help                  Prints help information
EOF
}


main() {
    
    local verbose=no
    for arg in "$@"; do
	case "$arg" in
            -h|--help)
                usage
                exit 0
                ;;
            -v|--verbose)
		# user wants to see verbose output
		verbose=yes
		;;
	    *)
		;;
	esac
    done

    get_architecture || return 1
    local _arch="$RETVAL"
    assert_nz "$_arch" "arch"

    if [ "$verbose" = "yes" ]; then
        msg_verbose "Discovered architecture: '$_arch'"
    fi

    local _ext=""
    case "$_arch" in
        *windows*)
        _ext=".exe"
        ;;
   esac

   local _url="$SB_UPDATE_ROOT/$_arch/sb$_ext"
   local _shasum_url="$SB_UPDATE_ROOT/$_arch/sb.shasum"
   
   msg ""
   msg "  Application url: '$_url'"
}

bold=""
underline=""
standout=""
normal=""
black=""
red=""
green=""
yellow=""
blue=""
magenta=""
cyan=""
white=""

get_architecture() {
    local _ostype="$(uname -s)"
    local _cputype="$(uname -m)"

    if [ "$_ostype" = Darwin -a "$_cputype" = i386 ]; then
        # Darwin `uname -s` lies
        if sysctl hw.optional.x86_64 | grep -q ': 1'; then
            local _cputype=amd64
        fi
    fi

    case "$_ostype" in

        Linux)
            local _ostype=linux
            ;;

        FreeBSD)
            local _ostype=freebsd
            ;;

        Darwin)
            local _ostype=darwin
            ;;

        MINGW* | MSYS* | CYGWIN*)
            local _ostype=windows
            ;;

        *)
            err "unrecognized OS type: $_ostype"
            ;;
    esac

    case "$_cputype" in

        i386 | i486 | i686 | i786 | x86)
            local _cputype=386
            ;;

        xscale | arm)
            local _cputype=arm
            ;;

        aarch64 | arm64)
            local _cputype=arm64
            ;;

        x86_64 | x86-64 | x64 | amd64)
            local _cputype=amd64
            ;;

        *)
            err "unknown CPU type: $_cputype"
    esac

    local _arch="$_ostype-$_cputype"

    OS="$_ostype"
    RETVAL="$_arch"
}


# Define a bunch of pretty output helpers
output() {
    fmt="$1"
    text="$2"
    printf -- "$fmt" "$text"
}

msg() {
    output "%s \n" "$1"
}

msg_verbose() {
    output "${bold}debug: ${normal}%s\n" "$1"
}

msg_err() {
    output "%s\n" "$1" 1>&2
}

err() {
    msg_err "$@"
    exit 1
}

assert_nz() {
    if [ -z "$1" ]; then err "assert_nz $2"; fi
}


main "$@" || exit 1

msg ""
msg "  Architecture determined successfully."
msg ""

} # this ensures the entire script is downloaded #

