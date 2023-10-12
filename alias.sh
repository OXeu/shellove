#!/bin/sh

alias ll="ls -ahl"
alias o="open ."
mkd(){
 mkdir -p $1
 cd $1
}
scr(){
 local device="phone"
 adb connect $device
 nohup scrcpy -Ss phone >/dev/null 2>&1 & 
}
