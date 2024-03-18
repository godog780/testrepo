#!/bin/sh
export LANG=C
if [ "$HOSTNAME" = "" ]; then   
  echo "bash run please (bash runcadocli.sh)"
  exit 100
fi
SHELL_PATH=$(pwd -P)
cado_path=$SHELL_PATH/cado-nfs
cpu_cores=$(lscpu | grep '^CPU(s):' | awk '{print $2}')
processes=$(( cpu_cores / 2 ))
masterIP="replace cado master ip address"
cadoPort=24242
msgPort=29291

ps augx | grep "cado-nfs-client.py" | grep -v "grep" | awk '{print $2}' | xargs kill

./cadocli $cado_path $masterIP $cadoPort $msgPort $processes $cado_path $HOSTNAME
#screen -ls | grep cadocli_ | grep -E '\s+[0-9]+\.' | awk -F ' ' '{print $1}' | while read s; do screen -XS $s quit; done
#screen -dmS cadocli_01 ./cadocli $cado_path 192.168.0.4 24242 29291 6 "/tmp/$(uuidgen)" $HOSTNAME
#screen -dmS cadocli_02 ./cadocli $cado_path 192.168.0.5 24242 29291 5 "/tmp/$(uuidgen)" $HOSTNAME
#screen -dmS cadocli_03 ./cadocli $cado_path 192.168.0.6 24242 29291 5 "/tmp/$(uuidgen)" $HOSTNAME
