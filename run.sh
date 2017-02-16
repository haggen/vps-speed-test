#!/usr/bin/env bash

read -r -d '' output <<EOF
time_connect: %{time_connect}s
time_namelookup: %{time_namelookup}s
time_pretransfer: %{time_pretransfer}
time_starttransfer: %{time_starttransfer}s
time_redirect: %{time_redirect}s
time_total: %{time_total}s
EOF

printf "Domain\tLatency\tSpeed\tLookup\tTime\n"
cat URL | while read url; do
  domain=${url%/*}
  domain=${domain#*//}
  latency=$(ping -c4 $domain | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
  curl -Lo /dev/null -skw "$domain\t$latency\t%{speed_download}\t%{time_namelookup}\t%{time_total}\n" $url
done | tee -a run.log
