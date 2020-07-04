#!/bin/bash
PATH=$PATH:/app:/usr/local/bin
CMD="${@}"

display_usage() {
    echo "Available commands:"
    echo "      channel_scan.sh [-h]"
    echo "      channel_report.sh [-h]"
    echo "      hdhomerun_config"
    echo ""
}

# check whether user had supplied -h or --help . If yes display usage
if [[ ($1 == "--help") || $1 == "-h" ]]; then
    display_usage
    exit 0
else
    # Run the commands
    $CMD
fi
