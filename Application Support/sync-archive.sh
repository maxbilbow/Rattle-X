. functions.sh

r_cmd='-av'
start_log "sync.log" -a
#Count how many in $@

#create array masters(count/2)
declare -a MASTER
#create array slaves(count/2)
declare -a SLAVE

find_archive () { #location ref code master copy
local temp
local c=0
local location="$1"
local ref="$2"
local master="$3"
local copy="$4"
for f in "$location"/*; do
	temp=$(find "$f" -type d -maxdepth 1 -name "$ref??? $master")
	
	#echo "temp: $temp"
	if [[ "$temp" == *" $master" ]]; then
		MASTER[$c]="$temp"
		
		archive="$(basename "${MASTER[$c]}")" # $copy
		echo "Found: $archive"
		archive="$(basename ${archive% $master}) $copy"
		echo "Looking for: $archive"
		
		for g in "$location"/*; do
			temp=$(find "$g" -type d -maxdepth 1 -name "$archive")
			if [[ "$temp" == *" $copy" ]]; then
				SLAVE[$c]="$temp"
				
				archive="$(basename "${MASTER[$c]}")" # $copy
				#echo "Found: $archive"
				echo "Master $c: ${MASTER[$c]}"
				echo "Slave  $c: ${SLAVE[$c]}"
				
				
				go=$(yes_pop "process the following?
   SOURCE: ${MASTER[$c]}
   TARGET: ${SLAVE[$c]}")
   				if [ $go = 1 ]; then
   					((c++))
   				else
   					 SLAVE[$c]="$(p_shared TEMP)"
   				fi
   				
   				
				#done
			#else
				#echo "$archive not found"
			fi
		done
		
			
		#done
		#echo "m is now $m"
	else
		echo "Archives not found"
	fi
	
	
	echo
	
	
	
done
#exit 0
}

sync_archives () {
cmd='';check=''; local n=0
for i in "${MASTER[@]}"; do
	
		for j in "${SLAVE[@]}"; do
			if [[ $(basename "${i% Master}") == $(basename "${j% Slave}") ]]; then
				echo "MATCH $(basename '"'${i% Master}'"')"
				echo "$i"
				echo "$j"
				echo
				rsync "$1" "$i/" "$j" "$2"
			fi
		done
		
done


}

log="$(p_shared logs)/sync.log"
touch "$log"
main #| tee -a "$log"

find_archive /Volumes RM Master Slave
#build_sync

quit_pop "Good to go?" 

sync_archives $r_cmd --delete



#$check"
#"$cmd"


