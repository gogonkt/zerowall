#!/bin/bash

# wget -c 'http://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt'
echo -e "function FindProxyForURL( url, host )\n{\n\tif ( shExpMatch(url, \"*google.com*\")"

# base64 -d  ./gfwlist.txt \\
curl 'http://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt' 2>/dev/null \
    | base64 -d \
    | sed 's/@\||\|^\.\|\/$//g' |sort -u \
    | awk '!(/^$/||/^!/||/\[Auto/||/\^h/) {print "\t\t|| shExpMatch(url, \"*"$1"*\")"}' 
            #awk: /^$/ 去除空行，/!/ ! 開頭 /[Auto/ [AutoProxy 行  
            #sed: 去除"@"，"|"，"^."，"/$"

echo -e "\t\t)\n\t\treturn \"PROXY 127.0.0.1:8118\";\n\telse\n\t\treturn "DIRECT";\n}"
