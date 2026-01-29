#!/bin/bash

# Memory monitoring harness for autorest validation

# Start memory monitor in background
monitor_memory() {
    local pid=$1
    echo "Starting memory monitor for PID: $pid"
    echo ""
    echo "Timestamp,Proc_RSS_MB,Proc_VSZ_MB,CPU%,Sys_Used_MB,Sys_Total_MB,Sys_Avail_MB"
    while kill -0 "$pid" 2>/dev/null; do
        if [[ -d "/proc/$pid" ]]; then
            # Get process memory info from /proc
            rss_kb=$(awk '/VmRSS/ {print $2}' /proc/$pid/status 2>/dev/null || echo "0")
            vsz_kb=$(awk '/VmSize/ {print $2}' /proc/$pid/status 2>/dev/null || echo "0")
            rss_mb=$((rss_kb / 1024))
            vsz_mb=$((vsz_kb / 1024))
            cpu=$(ps -p $pid -o %cpu= 2>/dev/null || echo "0")
            
            # Get system-wide memory info from /proc/meminfo
            mem_total_kb=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
            mem_avail_kb=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
            mem_total_mb=$((mem_total_kb / 1024))
            mem_avail_mb=$((mem_avail_kb / 1024))
            mem_used_mb=$((mem_total_mb - mem_avail_mb))
            
            echo "$(date '+%H:%M:%S'),$rss_mb,$vsz_mb,$cpu,$mem_used_mb,$mem_total_mb,$mem_avail_mb"
        fi
        sleep 5
    done
    echo "Process completed."
}

echo "Setting up temp file for output" 
TEMP_OUTPUT=$(mktemp /tmp/autorest_output.XXXXXX)
echo "Temp output file: $TEMP_OUTPUT"

echo "=== Starting autorest validation with memory monitoring ==="
echo "Working directory: $(pwd)"
echo ""

# Show initial system memory state
echo "Initial system memory:"
free -h
echo ""

# Run the command in background
NODE_OPTIONS=--max-old-space-size=32768 npm exec --no -- autorest \
    --v3 \
    --spectral \
    --azure-validator \
    --semantic-validator=false \
    --model-validator=false \
    --message-format=json \
    --openapi-type=arm \
    --openapi-subtype=arm \
    --use="$(pwd)/node_modules/@microsoft.azure/openapi-validator" \
    --tag=package-preview-2025-10-01-preview \
    specification/machinelearningservices/resource-manager/readme.md 2>&1 > "$TEMP_OUTPUT" &

CMD_PID=$!
echo "Command PID: $CMD_PID"
echo ""

# Start memory monitoring
monitor_memory $CMD_PID &
MONITOR_PID=$!

# Wait for main command to finish
wait $CMD_PID
EXIT_CODE=$?

# Kill monitor
kill $MONITOR_PID 2>/dev/null

echo "Command output is stored in: ${TEMP_OUTPUT}"
echo ""
echo "Final system memory:"
free -h
echo ""
echo "=== Command finished with exit code: $EXIT_CODE ==="
exit $EXIT_CODE
