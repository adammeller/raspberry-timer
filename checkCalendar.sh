#!/bin/bash

echo 11 > /sys/class/gpio/unexport
echo 11 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio11/direction

while [ 1 ]
do
   echo "--------------------"
   echo "Start:"
   startYear=`date +%Y-%m-%d`
   echo $startYear
   startHour=`date +%H`
   echo $startHour
   startMinute=`date +%M`
   echo $startMinute

sleep 61

   echo "Stop:"
   stopYear=`date +%Y-%m-%d`
   echo $stopYear
   stopHour=`date +%H`
   echo $stopHour
   stopMinute=`date +%M`
   echo $stopMinute


doCheck=`curl -i -X GET "https://www.googleapis.com/calendar/v3/calendars/mcb4e0kliffplfd661lfoo11mg@group.calendar.google.com/events?singleEvents=true&timeMax="$stopYear"T"$stopHour"%3A"$stopMinute"%3A00%2B02%3A00&timeMin="$startYear"T"$startHour"%3A"$startMinute"%3A00%2B02%3A00&key=AIzaSyCAWiUbsA5GRmojEJQU6aC-MRBjGK1zlM0"`

echo $doCheck
if [[ "$doCheck" == *start* && "$doCheck" == *L1* ]]
then
	echo "turn on lamp L1"
	echo "0" > /sys/class/gpio/gpio11/value
else
	echo "turn off the lamp L1"
	echo "1" > /sys/class/gpio/gpio11/value
fi

done
