#!/bin/bash

echo $(uptime) $(cat $1) |
tr : ' ' | tr , ' ' | awk '
{
  dd=$5
  hh=$7
  mm=$8
  current_uptime=dd*24*60+hh*60+mm
  if (current_uptime>$19) print current_uptime
  else print $19
}	
'
