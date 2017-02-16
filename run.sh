#!/usr/bin/env bash
printf "Domain Latency Speed Time\n"
cat URL | while read url; do
  domain=${url%/*}
  domain=${domain#*//}
  latency=$(ping -c4 $domain | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
  curl -Lo /dev/null -skw "$domain $latency %{speed_download} %{time_total}\n" $url
done | tee -a run.log
