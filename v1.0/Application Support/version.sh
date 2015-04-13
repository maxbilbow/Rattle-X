#!/bin/sh

#  version.sh
#  RattleX
#
#  Created by Max Bilbow on 27/01/2015.
#  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.

. functions.sh

readonly VERSION="0.2.3"
#let rx_subversion=0.03
#rx_subversion=0

function rx_init() {
    RattleX="Rattle X"
    start="/Volumes/Rattle X"
    root="$start/root"
    target="/Users/Shared"
    get_password
#exit 2
    get_prefs
    dev echo "finished init"

}

compareVersions ()
{
typeset    IFS='.'
typeset -a v1=( $1 )
typeset -a v2=( $2 )
typeset    n diff

for (( n=0; n<4; n+=1 )); do
diff=$((v1[n]-v2[n]))
if [ $diff -ne 0 ] ; then
[ $diff -le 0 ] && echo '-1' || echo '1'
return
fi
done
echo  '0'
} # ----------  end of function compareVersions  ----------


version_check() {
local var=-10
local alert="Checking Version...\n\n" #VERSION: $VERSION \nThis version: $this_version\n\n"
if  [ -z "$this_version" ] ; then
dev quit_pop "setting prefs"
p_shared -set version ""

alert+="Version $this_version not set $VERSION."

exit 2
else


    local var=$(compareVersions $VERSION $this_version)


case $var in
-1) alert+="Your version is newer\n\n   Current: $this_version > New: $VERSION\n"; exit_status=1 ;;
0) alert+="Rattle X appears to be up to date\n\n   Current: $this_version == New: $VERSION \n\nContinue with install anyway?";;
1) alert+="You do not have the latest version of Rattle X\n\n   Current: $this_version < New: $VERSION\n\nProceed with install?" ;;
-10) alert+="Your current version is older than 3.0." ;;
*) alert+="Something has gone wrong:\n\n   Current: $this_version ? New: $VERSION" ;;
esac

fi

install_type=$(cancel_pop "$alert" Upgrade Install)
_exit_

}



