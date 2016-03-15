#!/bin/bash

another="y"
correcthours=""
startdate=$(date "+%F")
enddate=$(date "+%F")
code="MGHPCC/INTERN"
totalHours=0
paytables=()

getData() {



#echo "What is your username?"
#read username

#if [ '$username' \< "a"  ];then
username='lgardner'
#echo $username

#fi 

#echo "What was the start date [YYYY-MM-DD]?"
#read startdate

#if [ '$startdate' \< "a" ]; then
startdate=$(date "+%F")
#echo $startdate
#fi



#echo "What is the end date [YYYY-MM-DD]?"
#read enddate
#if [ '$enddate' \< "a" ]; then
enddate=$(date "+%F")
#fi

}

calculateHours() {
echo "What is the start time [00:00-24:00]?"
read starttime

echo "What is the end time [00:00-24:00]?"
read endtime
hours=$(expr $(date -d "$enddate $endtime" "+%s") - $(date -d "$startdate $starttime" "+%s"))
hours=$(echo "scale=2; $hours/60" | bc)
#hours1=$(echo "scale=0; $hours%15" | bc)
#hours2=$(echo "scale=2; $hours-$hours1" | bc)
#hours=$(echo "scale=2; $hours2/60" | bc)
hours=$(echo "scale=2; $hours/60" | bc)

rounding=${hours: -2}

if [ $rounding -gt 0 ] && [ $rounding -lt 13 ];then
	hours=${hours/%$rounding/00}
elif [ $rounding -gt 12 ] && [ $rounding -lt 38 ];then
	hours=${hours/%$rounding/25}
elif [ $rounding -gt 37 ] && [ $rounding -lt 63 ];then
	hours=${hours/%$rounding/50}
elif [ $rounding -gt 62 ] && [ $rounding -lt 88 ];then
	hours=${hours/%$rounding/75}
elif [ $rounding -gt 87 ] && [ $rounding -lt 100 ];then
	hours=${hours/%$rounding/}
	hours=$(echo "scale=2; $hours+1." | bc)
fi
	 
}

hoursfun() {
echo "Your total amount of hours is" $hours"."
echo "Is this correct? [Y/N]"

read correcthours

if [ $correcthours == "Y" ];then 
	totalHours=$(echo "$totalHours+$hours" | bc) 
	echo "Total Hours:" $totalHours
elif [ $correcthours == "y" ];then
	totalHours=$(echo "$totalHours+$hours" | bc) 
	echo "Total Hours:" $totalHours
elif [ $correcthours == "N" ];then 
	#echo "How many hours did you work"
	#read hours
	calculateHours
elif [ $correcthours == "n" ];then
	#echo "How many hours did you work?"
	#read hours
	calculateHours
	
else
	echo "Please insert a correct response"
	read correcthours
fi

}

#paycode() {
#if [ $code \< "A" ]; then
#code='MGHPCC/INTERN'

#elif [ $code == "y" ]
#then
#	code="MGHPCC/INTERN"
#elif [ $code == "Y" ]
#then
#	code = "MGHPCC/INTERN"
#elif [ $code == "n" ]
#then
#	echo "What is your payment classification code?"
#	read newcode
#	code=$newcode
#elif [ $code == "N" ]
#then 
#	echo "What is your payment classification code?"
#	read newcode
#	code=$newcode
#else
#code=$code


#fi
#}

didToday() {


echo "What did you do today?"
read didtoday


}


anotherPay() {
echo "Your payment information is" 
echo ""
echo ""
table="\n"$username"|"$startdate"|"$starttime"|"$enddate"|"$endtime"|"$hours"|"$code"|Y|N|"$didtoday"\n"
paytables=(${paytables[@]} $table )
echo -e $table
echo ""
echo ""
echo ""
echo ""
echo "Would you like to create another pay table? [Y/N]"
read another

if [ $another == "Y" ];then 
	echo "Excellent let's get back into it!"
elif [ $another == "y" ];then
	echo "Excellent let's get back into it!"
elif [ $another == "N" ];then 
	echo "Ok, I hope this was useful."
elif [ $another == "n" ];then
	echo "Ok, I hope this was useful."	
else
	echo "Please insert a correct response"
	read another

fi
}





main() {


getData

calculateHours

hoursfun

#paycode

didToday

anotherPay
}

while  [[ $another == 'y' ]];do
main
done
echo ""
echo -e ${paytables[@]}
echo ""
echo -e ${paytables[@]} >> /home/Lawrence/git/hours/records/$(date -d "$D" '+%m')-$(date -d "$D" '+%Y')-paytables
#touch /home/Lawrence/git/hours/records/$(date -d "$D" '+%m')-$(date -d "$D" '+%Y')
echo "$totalHours" >> /home/Lawrence/git/hours/records/$(date -d "$D" '+%m')-$(date -d "$D" '+%Y')-hours
runningTotal=$(echo $(awk '{s+=$1} END {print s}' /home/Lawrence/git/hours/records/$(date -d "$D" '+%m')-$(date -d "$D" '+%Y')-hours))
echo "runningTotal: $runningTotal"

echo 'Would you like to send this email now?'
read email
if [ $email == "y" ];then
	echo -e "${paytables[@]}" | mail -s "hours for $(date "+%F") $runningtotal" sb@techsquare.com
else break
fi
