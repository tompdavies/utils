#!/usr/bin/env bash
#===============================================================================
# Make your bash env feel like home, when you're on an unfamiliar machine
#===============================================================================

force_colour_off=false

tempsrcfile=/tmp/tempsrcfile

function check_shlevel {
    if [ "$SHLVL" -lt 3 ]
    then
        echo "ERROR: please run in a sub-shell (current \$SHLVL=$SHLVL)"
        exit 1
    fi
}

function set_use_colours {
    use_colours=false

    case "$TERM" in
        xterm-color|*-256color|screen) use_colours=true;;
    esac

    if [ "${force_colour_off}" == "true" ]
    then
        use_colours=false
    fi
}

function init_tempsrcfile {
    echo "# Temp file for bash configuration" > ${tempsrcfile}
    echo "# Can be deleted at any time" >> ${tempsrcfile}
}

function set_aliases {
    if [ "$use_colours" = true ]; then
        echo "alias ls='ls -F --color=auto'" >> ${tempsrcfile}
    fi
    echo "alias ll='ls -l'" >> ${tempsrcfile}
    echo "alias la='ls -la'" >> ${tempsrcfile}
}

function set_ps1_prompt {
    if [ "$use_colours" = true ]; then
        echo "PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;36m\]\W \\$\[\033[00m\] '" >> ${tempsrcfile}
    else
        echo "PS1='\u@\h \W \\$ '" >> ${tempsrcfile}
    fi
    echo 'PS1="\[\e]0;\u@\h:\w\a\]$PS1"' >> ${tempsrcfile}
}

function echo_instructions {
    echo "Now run the following to set your prompt (and remove the temp file):"
    echo "source ${tempsrcfile} && rm ${tempsrcfile}"
}

# Main

check_shlevel
set_use_colours
init_tempsrcfile
set_aliases
set_ps1_prompt
echo_instructions
