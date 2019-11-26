#!/bin/sh
#!/bin/bash
#!/usr/bin/ruby

#### This script can run in PASSIVE , MIXED or AGGRESSIVE modes and outputs the scan results to a file (/tmp/wpscan-batch-results.txt).
#### Usage: ./wpscan-bold.sh passive
#### Usage: ./wpscan-bold.sh mixed
#### Usage: ./wpscan-bold.sh aggressive

# GLOBAL VARIABLE
APITOKEN='TAKE-API-TOKEN-FROM-https://wpvulndb.com/users/sign_up'
WordPressURLList="/tmp/WordPressURL.List"
WordPressScanResult="/tmp/wpscan-bold-results.txt"

# Removing old log file and creating a fresh log file
rm -rf $WordPressScanResult
touch $WordPressScanResult
echo "$(date +%Y-%m-%d_%H:%M) : Starting WordPress Scanning"
echo "$(date +%Y-%m-%d_%H:%M) : Old log file deleted and new log file created at $WordPressScanResult ... " >> $WordPressScanResult

# MODE selection based on paramter passed
if [ "$1" = "passive" ]; then
        echo "\nPASSIVE MODE SELECTED" >> $WordPressScanResult
elif [ "$1" = "mixed" ]; then
        echo "\nMIXED MODE SELECTED" >> $WordPressScanResult
elif [ "$1" = "aggressive" ]; then
        echo "\nAGGRESSIVE MODE SELECTED" >> $WordPressScanResult
else
        exit
fi

echo "$(date +%Y-%m-%d_%H:%M) : Starting Scanning ... "

# Updating WPSCAN Database
echo "$(date +%Y-%m-%d_%H:%M) : Updating WPScan and its Vulnerbility-Check DB ..." >> $WordPressScanResult
gem update wpscan >> $WordPressScanResult
wpscan --no-banner --update >> $WordPressScanResult
echo "$(date +%Y-%m-%d_%H:%M) : WPScan and its Vulnerbility DB Updated. \n" >> $WordPressScanResult

# Reading lines from WordPressURL.List file
while IFS= read -r line
do
        echo "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" >> $WordPressScanResult
        echo "$(date +%Y-%m-%d_%H:%M) : Scanning started : $line " >> $WordPressScanResult

	wpscan --no-banner --api-token $APITOKEN --url $line --enumerate vp,vt,tt,cb,u,m,dbe --force --ignore-main-redirect --random-user-agent --wp-content-dir /wp-content/ --wp-plugins-dir /plugins/ --plugins-detection $1 >> $WordPressScanResult  

        echo "$(date +%Y-%m-%d_%H:%M) : Scanning completed : $line " >> $WordPressScanResult
        echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" >> $WordPressScanResult
done <"$WordPressURLList"
echo "$(date +%Y-%m-%d_%H:%M) : All Scanning completed. Generating report at  $WordPressScanResult ... "

echo "Hi, This is an auto generated mail. Please find the attached log file which shows VA of WordPress portals" | mail -s "WordPress-VA-Status" -r "WordPressVAStatus<FromEmail-ID@example.com>" -A $WordPressScanResult YourEmail-ID@example.com
