# This script is for ethical use only. Please use it for finding complete set of vulnerbilities in a WordPress based portal.
# This script can run in PASSIVE , MIXED or AGGRESSIVE modes and outputs the scan results to a file (/tmp/wpscan-batch-results.txt).
# Usage: ./wpscan-bold.sh passive
# Usage: ./wpscan-bold.sh mixed
# Usage: ./wpscan-bold.sh aggressive

1. Install wpscan

apt-get install wpscan

2. Copy the WordPressURL.List to /tmp and add the list of Wordpress based URLs line by line

3. Sign-up and create a free TOKEN from:

https://wpvulndb.com/users/sign_up

4. Modify WordPressScan.sh and replace the value of :

APITOKEN='TAKE-API-TOKEN-FROM-https://wpvulndb.com/users/sign_up'

5. Run the script of your choice (passive / mixed / aggressive):

./wpscan-bold.sh passive

OR 

./wpscan-bold.sh mixed

OR

./wpscan-bold.sh aggressive


NOTE: For any help, contact on aks82info@gmail.com and follow my blog techfrozen.blogspot.com
You are free to modify the code and suggest to commit.

CHEERS!!
