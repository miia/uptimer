#!/bin/bash

echo $(cat $1) $(uptime) |
tr : ' ' | tr , ' ' | awk '
{
  dd=$6
  hh=$8
  mm=$9
  current_uptime=dd*24*60+hh*60+mm
  if (current_uptime>$1) print current_uptime
  else print $1
}	
'
