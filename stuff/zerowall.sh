#!/bin/bash

#wget -c 'http://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt'
echo -e "function FindProxyForURL( url, host )\n{\n\tif ( shExpMatch(url, \"*google.com*\")"

base64 -d  ~/share/firefox.setting/gfw/gfwlist.txt \
    | sed 's/@\||\|^\.\|\/$//g' |sort -u \
    | awk '!(/^$/||/^!/||/\[Auto/||/\^h/) {print "\t\t|| shExpMatch(url, \"*"$1"*\")"}' 
            #awk: /^$/ 去除空行，/!/ ! 開頭 /[Auto/ [AutoProxy 行  
            #sed: 去除"@"，"|"，"^."，"/$"

echo -e "\t\t)\n\t\treturn \"PROXY 127.0.0.1:8118\";\n\telse\n\t\treturn "DIRECT";\n}"
# base64 -d  ~/share/firefox.setting/gfw/gfwlist.txt | sed 's/@\||\|^\.\|\/$//g' |sed '/!\|\^h/d' |sort -u
