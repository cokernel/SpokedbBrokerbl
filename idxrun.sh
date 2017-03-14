#! /bin/bash

interval=20
program="bash /home/rails/proc/chk4idx.sh"

while true; do
  $program
  now=$(date +%s)
  remainder=$(( $now % $interval ))
  delay=$(( ($interval - $remainder) % $interval ))
  sleep $delay
done
