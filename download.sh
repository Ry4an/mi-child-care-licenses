#!/bin/bash
for PAGENUM in {01..02} ; do
    curl 'https://childcaresearch.apps.lara.state.mi.us/Home/SearchResults' \
      -H 'Connection: keep-alive' \
      -H 'Accept: application/json, text/javascript, */*; q=0.01' \
      -H 'DNT: 1' \
      -H 'X-Requested-With: XMLHttpRequest' \
      -H 'User-Agent: Mozilla/5.0 (X11; CrOS x86_64 12871.102.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.141 Safari/537.36' \
      -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
      -H 'Origin: https://childcaresearch.apps.lara.state.mi.us' \
      -H 'Sec-Fetch-Site: same-origin' \
      -H 'Sec-Fetch-Mode: cors' \
      -H 'Sec-Fetch-Dest: empty' \
      -H 'Referer: https://childcaresearch.apps.lara.state.mi.us/' \
      -H 'Accept-Language: en-US,en;q=0.9' \
      --data "pq_datatype=JSON&pq_curpage=${PAGENUM}&pq_rpp=100" \
      --compressed \
      --output page-${PAGENUM}.json
done

jq -r '.Data[]|[.CdcLicNbr,.CdcName,.CdcAddr,.CdcCity,.CdcZip,.CdcLicName,.CdcType,.CdcCnty,.CntyDesc,.FacilityType]|@tsv' page-*.json > all-licenses.tsv
