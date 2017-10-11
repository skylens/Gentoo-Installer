#!/bin/bash
# show system info
hostname=`hostname` 

printf "Host Name:\t%s\t\tProcesses:\t%s\n" $hostname $processes
printf "Memory usage:\t%s\t\tSystem uptime:\t%s\n" $memory_usage "$time"
printf "Usage on /:\t%s\t\tSwap usage:\t%s\n" $root_usage $swap_usage
printf "System load:\t%s\t\tInternal IP Address:\t%s\n" $load $internalip
printf "Local Users:\t%s\t\tExternal IP Address:\t%s\n"  $users $externalip
echo