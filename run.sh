#!/usr/bin/env bash
printf "Domain\tLatency\tSpeed\tLookup\tTime\n"
cat URL | while read url; do
  domain=${url%/*}
  domain=${domain#*//}
  latency=$(ping -c4 $domain | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
  curl -Lo /dev/null -skw "$domain\t$latency\t%{speed_download}\t%{time_namelookup}\t%{time_total}\n" $url
done | tee -a run.log
