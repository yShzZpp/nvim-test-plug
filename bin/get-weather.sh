#!/bin/bash

data=$1
 
function get_json_value()
{
  local json=$1
  local key=$2

  if [[ -z "$3" ]]; then
    local num=1
  else
    local num=$3
  fi

  local value=$(echo "${json}" | awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'${key}'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p)

  data="${data} ${value}"
  # echo $data
}

weatherDateRoot=http://www.weather.com.cn/data/sk/101280601.html
weatherDataFile=weather.html
 
wget $weatherDateRoot -O $weatherDataFile > /dev/null 2>&1

json=`cat ./weather.html`

# $(get_json_value $json "city")
# $(get_json_value $json "temp")
# $(get_json_value $json "wd")
# $(get_json_value $json "ws")

get_json_value $json "city"
get_json_value $json "temp"
get_json_value $json "WD"
get_json_value $json "WS"
echo $data > "weather-data"
rm ./weather.html
# echo $data
