#!/bin/bash

line=( $(cat schedule.csv | cut -d ',' -f1) )
day=( $(cat schedule.csv | cut -d ',' -f2) )
time=( $(cat schedule.csv | cut -d ',' -f3) )
currentTime=$(date +"%H:%M")


echo "${currentTime}"


echo "Please give the bus number"
read userbusline
echo "Please choose a day(Monday : 1, Thuesday : 2 ect..)"
read userday
echo "Time you look after(leave empty if you want to use the current time)(format: HH:MM):"
read usertime


Logic () {
COUNTER=0
for var in ${line[*]}
do
	if [ "${var}" == "$1" ]
	then
		if [[ "${day[$COUNTER]}" =~ "$2" ]]
		then
			if [[ ${time[COUNTER]} > $3 ]]
			then
			echo "The next bus on line $1 on the chosen day after $3 will be started at ${time[COUNTER]}"
			return
			fi
		fi
	fi
	COUNTER=`expr $COUNTER + 1`
done
echo "No more bus on the line $1 after $2 on the selected day"
}

if [ "${usertime}" == '' ]
then
	echo "No time set by user. Using current time"
	Logic $userbusline $userday $currentTime
else
	echo "Chosen time: ${usertime}"
	Logic $userbusline $userday $usertime
fi


