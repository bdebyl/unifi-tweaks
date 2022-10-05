#!/bin/sh
## 98-vlan_to_wan2.sh
## A script to add policy-based routing to send vlan2 to wan2 to the UDM-Pro
## Includes monitoring to re-add rules in the event of config changes
## Use in conjunction with 99-disable_wan_failover.sh


vlan110_to_wan_monitor() {
  (while :; do
  ip rule show | grep 32400 &> /dev/null ||
    (ip rule add pref 32400 from all iif br110 lookup 202)
  sleep 1
  done) &
}

vlan110_to_wan_monitor

## Uncomment below to add an additional vlan to route out wan2
## Replace vlan1234 and br1234 with your desired vlan number

#run_vlan1234_to_wan_watcher() {
#        (while :; do
#                    ip rule show | grep 32401 &> /dev/null ||
#                        (ip rule add pref 32401 from all iif br1234 lookup 202)
#                sleep 1
#        done) &
#}

#run_vlan1234_to_wan_watcher
