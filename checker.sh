#!/bin/bash

# Function to ping IP and check its status
ping_ip() {
    local ip=$1
    local output
    output=$(ping -c 1 -W 1 "$ip" 2>&1)

    if [[ $output == *"1 packets received"* ]]; then
        echo "Alive"
    elif [[ $output == *"Destination Host Unreachable"* ]]; then
        echo "Unreachable"
    else
        echo "Dead"
    fi
}

# Function to check IPs from a file
check_ips_from_file() {
    local filename=$1
    local ips=($(<"$filename"))
    local results=()

    # Loop through each IP and check its status
    for ip in "${ips[@]}"; do
        status=$(ping_ip "$ip")
        results+=("$ip $status")
        echo -ne "Pinging IPs: $((++counter))/${#ips[@]}\r"
        sleep 0.1
    done

    echo "${results[@]}"
}

# Function to display results with color
display_results() {
    local results=("$@")
    echo -e "\nPing Results:"
    echo "-------------"

    for result in "${results[@]}"; do
        ip=$(echo $result | awk '{print $1}')
        status=$(echo $result | awk '{print $2}')

        if [[ $status == "Alive" ]]; then
            echo -e "$ip \e[32m$status\e[0m"
        elif [[ $status == "Unreachable" ]]; then
            echo -e "$ip \e[33m$status\e[0m"
        else
            echo -e "$ip \e[31m$status\e[0m"
        fi
    done
}

# Main script execution
input_file="ip.txt"
results=($(check_ips_from_file "$input_file"))
display_results "${results[@]}"