#!/bin/sh

#  popups.sh
#  RattleX
#
#  Created by Max Bilbow on 27/01/2015.
#  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.




pop() {
local s='"'$2'"'
local n=$(($#-1))
for arg in "${@:3}"; do
s+=', "'$arg'"'
done

local x=`/usr/bin/osascript <<EOT
tell application "System Events"
activate
set myReply to button returned of (display dialog "$1" default button $n buttons { $s })
end tell
EOT`

echo 'echo '$x
}

quit_pop(){
echo "$?"
local stop=$(pop "$1" "Quit" "Continue")
#local stop=$([ "$#" < "3"] && $(pop "$1" "Quit" "Continue") || $(pop "$@" "Cancel"))
#echo $quit
if [[ "$stop" = "Quit" ]]; then
    echo $stop
    _exit_ 2
else
    echo $stop
fi
}


ok_pop() {
quit_pop "$1" "Cancel " "OK"
}

yes_pop(){
echo $(pop "$1" "No" "Yes")
#return $x
}

cancel_pop(){
#echo "$? $#"
local stop=$([[ $# < 2 ]] && $(pop "$1" "Quit" "Continue") || $(pop "$@" "Cancel "))
#echo $quit

if [ "$stop" = "Quit" ]; then
echo "$stop"
_exit_ 2
elif [ "$stop" = "Cancel" ]; then
echo "$stop"
_exit_ 1
else
    echo "$stop"
fi
}

choose_folder() {
x=`/usr/bin/osascript <<EOT
tell application "SystemUIServer" to return POSIX path of (choose folder)`
echo "$x"
}


function do_sudo() {

echo `/usr/bin/osascript <<EOT
do shell script "$@" user name "root" password "$password"
EOT`
#`/usr/bin/osascript do shell script "echo hello" user name "root" password "$password"`
#echo $@
}


function get_password() {
    password=`/usr/bin/osascript <<EOT
tell application "System Events"
set theText to "Password needed for " & name of current user
end tell
display dialog theText default answer "" with hidden answer
set the adminpass to the text returned of the result
EOT`
echo $password


}







