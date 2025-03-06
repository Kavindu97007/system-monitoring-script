#!/bin/bash
###############
# Author: Kavindu
# Date: 06.03.2025
# System Monitoring Script
###############

set -x # degug mode
set -e # exit an error
set -o pipefail #handle pipe


# create a file
touch system_report.txt

# save this to system_report.txt

timestamp=$(date "+%Y-%m-%d")
echo "System Report -- ${timestamp}" >> system_report.txt
echo "---------------" >> system_report.txt

# Disk Usage
disk_usage=$(df -h / | grep / | awk '{print $5}' | tr -d '%')
echo "Disk Usage: ${disk_usage}%" >> system_report.txt

# memory usage
memory_usage=$(free -m | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')
echo "Memory Usage: ${memory_usage}%" >> system_report.txt

# CPU usage
cpu_usage=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | awk '{print int($1)}')
echo "CPU Usage: ${cpu_usage}%" >> system_report.txt

echo "---------------" >> system_report.txt

# print a message according to usage

if [ "$disk_usage" -ge 80 ]
        echo "Warning: Disk usage is high!" | tee -a system_report.txt # print and save in file
fi

if [ "$memory_usage" -ge 90 ]
        echo "Warning: Memory usage is high!" | tee -a system_report.txt

fi

if [ "$cpu_usage" -ge 75 ]
        echo "Warning: CPU usage is high!" | tee -a system_report.txt
fi