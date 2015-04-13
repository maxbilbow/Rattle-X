#!/bin/sh

#  functions.sh
#  X
#
#  Created by Max Bilbow on 21/12/2014.
#  Copyright (c) 2014 Rattle Media Ltd. All rights reserved.
. popups.sh
dev_mode=1
set -e
declare -i exit_status
exit_status=0


function dev() {
if [ $dev_mode ]; then
"$@"
fi
}

function _exit_() {

#dev echo "args $#, es $exit_status, arg $1"

exit_status+=$1

        if [[ $exit_status > 0 ]]; then
            exit $exit_status
#        else
#            dev echo "EXIT: $exit_status (No need to exit?)"
        fi
}



function safe_defaults() {

local var=$(defaults read ${@:2})
[ "$3" = "..." ] && dev quit_pop "
safe_defaults: $*
        VALUE: $var"

if [ -n "$var" ]; then
	#quit_pop "Does $3 exist?"
    if [ "$1" = "-get" ]; then
        echo  $(defaults read ${@:2})
    elif [ "$1" = "-set" ]; then
        defaults write ${@:2}
    else
        quit_pop "ERROR: $@"
    fi
else
	dev quit_pop "ERROR: $3 does not exist. Write ''?"
	if [ "$2" = "com.rattle.local" ]; then
    	defaults write ${@:2} ""
	elif [ "$2" = "/Library/Preferences/com.rattle.constants" ]; then
   		do_sudo "Defaults write com.rattle.constants $3 0.2.0"
	else
		echo "ERROR"
		_exit_ 2
    fi
		
fi


}


function p_shared(){
if [ "$1" = "-set" ]; then
    local s="Defaults write com.rattle.constants $2 '$3'"
    dev echo "$s"
do_sudo "$s"
else
    safe_defaults -get /Library/Preferences/com.rattle.constants $@
fi
}

function p_local(){
    if [ "$1" = "-set" ]; then
        defaults write com.rattle.local ${@:2}
    else
        safe_defaults -get com.rattle.local $@
    fi
}


function set_prefs (){
    p_shared -set APPS "$apps"
    p_shared -set CheckOutLocation "$checkOut"
    p_shared -set TEMP "$temp"
    p_shared -set fcpx "$fcpx"
    p_shared -set documents "$docs"
    p_shared -set drafts "$drafts"
    p_shared -set sharedDir "$docs"
    p_shared -set dropbox "$rattle_up"
    p_shared -set logs "$logs"
    if [ "$1" = "-all" ]; then
         p_local -set CheckInLocation "$checkIn"
    fi
#ln -sf /Users/Shared/Library/Preferences/com.rattle.constants.plist ~/Library/Preferences/com.rattle.constants.plist
#p_shared -set isShared -bool true
#p_shared -set isSet -bool true
}

function get_prefs (){
    apps=$(p_shared APPS)
    checkOut=$(p_shared CheckOutLocation)
    temp=$(p_shared TEMP)
    fcpx=$(p_shared fcpx)
    drafts=$(p_shared drafts)
    docs=$(p_shared documents)
    docs=$(p_shared sharedDir)
    #=$(p_shared isShared)
    rattle_up=$(p_shared dropbox)
    logs=$(p_shared logs)
    #logs=$(p_local logs)
    checkIn=$(p_local CheckInLocation)
    this_version=$(p_shared version)
}
#<key>aliasSet</key>
#<true/>
#<key>isSet</key>
#<true/>
#<key>isShared</key>
#<true/>
#get_pref constants isShared

function start_log () {
	local log="$1"
	local logs="$(p_shared logs)"
	#touch "$logs/$log"
	#echo tee "$2" "$logs/$log"
}






function safe_symlink() {
	local trg="$2"; local src="$1"
	if [ -d "$trg" ]; then
		[ $(yes_pop "overwrite $trg?") = 1 ] && ln -sf "$src" "$trg" || echo "no change to dropbox symlink"
	else
		[ $(yes_pop "Overwrite existing: $trg?") = 1 ] && ln -sf "$src" "$trg" || echo "no change to dropbox symlink"
	fi
}

