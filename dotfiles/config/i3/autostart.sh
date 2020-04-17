#!/bin/bash
grep -Rh Exec ~/.config/autostart | while read -r line ; do
   echo ${line:5}
   ${line:5} &
done
