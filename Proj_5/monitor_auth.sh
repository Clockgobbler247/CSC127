#!/bin/bash

#####################
### Proj_5 Script ###
#####################

## Parse out the information and send to a file
sudo tail -n 5000 /var/log/auth.log | grep -E -a "$(date +'%b %e')" | grep -E -a "failed authentication|authentication failure" >> /monitor/exceptions.log
