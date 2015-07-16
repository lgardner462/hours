#!/bin/bash

correcthours=""





hoursfun() {
read correcthours

if [ $correcthours == "Y" ];then 
	echo "Excellent!"
elif [ $correcthours == "y" ];then
	echo "Excellent!"
elif [ $correcthours == "N" ];then 
	echo "How many hours did you work"
	read hours
elif [ $correcthours == "n" ];then
	echo "How many hours did you work?"
	read hours
	
else
	echo "Please insert a correct response"
	read correcthours
fi

}

paycode() {

if [ $code == "y" ]
then
	code="MGHPCC/INTERN"
elif [ $code == "Y" ]
then
	code = "MGHPCC/INTERN"
elif [ $code == "n" ]
then
	echo "What is your payment classification code?"
	read newcode
	code=$newcode
elif [ $code == "N" ]
then 
	echo "What is your payment classification code?"
	read newcode
	code=$newcode

fi
}


main() {
echo "What is your username?"
read username

echo "What was the start date [YYYY-MM-DD]?"
read startdate


echo "What is the start time [00:00-24:00]?"
read starttime


echo "What is the end date [YYYY-MM-DD]?"
read enddate


echo "What is the end time [00:00-24:00]?"
read endtime


hours=$(expr $(date -d "$enddate $endtime" "+%s") - $(date -d "$startdate $starttime" "+%s"))
hours=$(echo "scale=2; $hours/60" | bc)
hours1=$(echo "scale=0; $hours%15" | bc)
hours=$(echo "scale=2; $hours-$hours1" | bc)
hours=$(echo "scale=2; $hours/60" | bc)







echo "Your total amount of hours is" $hours"."
echo "Is this correct? [Y/N]"

hoursfun


echo "Is your code MGHPCC/INTERN?"

read code

paycode

echo "What did you do today?"
read didtoday

echo "Your payment information is" 
echo ""
echo ""
echo $username"|"$startdate"|"$starttime"|"$enddate"|"$endtime"|"$hours"|"$code"|Y|N|"$didtoday
echo ""
echo ""
}

main


