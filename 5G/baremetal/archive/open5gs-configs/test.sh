#!/usr/bin/env bash 

tmux start-server

tmux new-session -d -s open5gs -n nrf -d "/usr/bin/env sh -c \"sudo open5gs-nrfd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/nrf.yml\"; /usr/bin/env sh -i" 
tmux new-window -t open5gs:1 -n scp  "/usr/bin/env sh -c \"sudo open5gs-scpd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/scp.yml\"; /usr/bin/env sh -i" 
tmux new-window -t open5gs:2 -n amf "/usr/bin/env sh -c \"sudo open5gs-amfd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/amf.yml\"; /usr/bin/env sh -i"
tmux new-window -t open5gs:3 -n smf  "/usr/bin/env sh -c \"sudo open5gs-smfd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/smf.yml\"; /usr/bin/env sh -i" 
tmux new-window -t open5gs:4 -n udm "/usr/bin/env sh -c \"sudo open5gs-udmd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/udm.yml\"; /usr/bin/env sh -i" 
tmux new-window -t open5gs:5 -n udr  "/usr/bin/env sh -c \"sudo open5gs-udrd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/udr.yml\"; /usr/bin/env sh -i" 
tmux new-window -t open5gs:6 -n pcf  "/usr/bin/env sh -c \"sudo open5gs-pcfd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/pcf.yml\"; /usr/bin/env sh -i" 
tmux new-window -t open5gs:7 -n ausf  "/usr/bin/env sh -c \"sudo open5gs-ausfd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/ausf.yml\"; /usr/bin/env sh -i" 
tmux new-window -t open5gs:8 -n bsf  "/usr/bin/env sh -c \"sudo open5gs-bsfd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/bsf.yml\"; /usr/bin/env sh -i" 
tmux new-window -t open5gs:9 -n nssf  "/usr/bin/env sh -c \"sudo open5gs-nssfd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/nssf.yml\"; /usr/bin/env sh -i" 
# tmux new-window -t open5gs:11 -n upf  "/usr/bin/env sh -c \"sudo open5gs-upfd -c /home/mathias/cluster-mgmt/5G/baremetal/open5gs-configs/upf.yml\"; /usr/bin/env sh -i" 

tmux attach -t open5gs
