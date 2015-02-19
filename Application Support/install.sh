

#  rattle.sh
#  X
#
#  Created by Max Bilbow on 21/12/2014.
#  Copyright (c) 2014 Rattle Media Ltd. All rights reserved.

. version.sh

#Define Constants
function set_defaults () {
    docs="$target/Rattle Local"
    fcpx="$docs/FCPX"
    checkOut="$fcpx/Checked Out"
    temp="$docs/TEMP"
    #drafts_l="$temp/Drafts (Masters)"
    drafts="$docs/Rattle Up/Production/Drafts"
    apps="/Applications/Rattle Apps"
    rattle_up="$docs/Rattle Up"
    logs="$rattle_up/Rattle Up/Backups/logs"
    if [ "$1" = "-all" ]; then
        checkIn = "$rattle_up/Rattle Up/Production/Checked In"
    fi
}


function start() {
rx_init
#password="$(get_password)"
version_check





if [[ "$install_type" = "Upgrade" ]]
then
    rx_upgrade
elif [[ "$install_type" = "Install" ]]
then
    rx_install
fi

p_shared -set version "$VERSION"
exit 2

if [ $(yes_pop "Master Install?") = 1 ]; then
    sudo rsync -av "$start/User/Library/" ~/Library
    set_defaults
    set_prefs
    rx_install
elif [ $(yes_pop "Recommended Upgrade?") = 1 ]; then

    rx_upgrade
fi




#log="$(p_shared logs)/install.log"
#touch "$log"
#install #| tee -a "$log"


}



function rx_upgrade() {
set_defaults
set_prefs
do_sudo rsync -avE "'$root/Library/'" /Library
#p_shared -set version "$VERSION"
}


function rx_install() {

set_prefs -all


safe_symlink ~/Dropbox/Rattle\ Up "$rattle_up"
safe_symlink "$apps" "$docs/Apps"


#echo $quit
#[ $quit = 1 ] && password || exit 0
#choose_folder

if [ $(yes_pop "Master install?") = 1 ]; then
#exit 0 #testing line
#Install Local settings

rsync -avE "$root/Applications/" /Applications


#install universal services
#echo "$password" |
sudo rsync -av "$root/Library/" /Library

#Install local file structure
rsync -avE "$root/Users/" /Users

#rsync -av "$start/About.txt" ~/Library/Application\ Support/RattleApps/About.txt

if [ $(yes_pop "Install dropbox structure?") = 1 ]; then
#Install local file structure
rsync -avE "$start/User/Dropbox/" ~/Dropbox
fi


fi
#Correct prefs symlink (IMPORTANT)
ln -sf /Library/Preferences/com.rattle.constants.plist ~/Library/Preferences/com.rattle.constants.plist

if [ $(yes_pop "Install default local preferences?") = 1 ]; then
#Install local prefs
rsync -av "$start/User/Library/" ~/Library
checkIn="/Users/Shared/Rattle Local/Rattle Up/Production/Checked In" #"$(choose_folder)"
p_local -set CheckInLocation "$checkIn"
fi



if [ $(yes_pop "Install Apps in Dock?") = 1 ]; then
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///$docs/</string><key>_CFURLStringType</key><integer>15</integer><key>showas</key><integer>3</integer></dict><key>file-label</key><string>RattleDocs</string><key>file-type</key><integer>2</integer></dict><key>tile-type</key><string>directory-tile</string></dict>" && killall -HUP Dock
defaults write com.rattle.local isSet -bool true
fi

}


start