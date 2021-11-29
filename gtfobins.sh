#!/bin/bash

find / -user root -perm /4000 2>/dev/null >> priv1.txt
cat priv1.txt | sed -e 's,/, ,g' >> priv2.txt
grep -oE '[^ ]+$' priv2.txt >> priv3.txt
sed 's/[[:blank:]]*$//;s/.*[[:blank:]]//' priv3.txt >> priv4.txt

rm priv1.txt priv2.txt priv3.txt

echo "Les potentielles élévations de privilège sont les suivantes : " >> results.txt

for line in $(cat priv4.txt); 
do 
    echo $line >> results.txt
    curl https://gtfobins.github.io/gtfobins/$line/ 2>/dev/null | grep -o '<pre><code>.*</code></pre>' >> results.txt;
    echo $line + ' end' >> results.txt
done

rm priv4.txt
open results.txt
