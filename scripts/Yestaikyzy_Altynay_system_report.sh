#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="$SCRIPT_DIR/../logs/Yestaikyzy_Altynay_system_report.log"

{
  echo "=================================================="
  echo " SYSTEM REPORT"
  echo "=================================================="
  echo "Student      : Altynay Yestaikyzy (Group IT2-2309, ID 37590)"
  echo "Date & time  : $(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo "Username     : $(whoami)"
  echo "Hostname     : $(hostname)"

  echo
  echo "--- Operating system & kernel ---"
  echo "OS           : $(sw_vers -productName) $(sw_vers -productVersion) (build $(sw_vers -buildVersion))"
  echo "Kernel       : $(uname -srm)"

  echo
  echo "--- CPU ---"
  echo "Model        : $(sysctl -n machdep.cpu.brand_string)"
  echo "Cores        : $(sysctl -n hw.physicalcpu) physical / $(sysctl -n hw.logicalcpu) logical"

  echo
  echo "--- Memory (vm_stat) ---"
  TOTAL_BYTES=$(sysctl -n hw.memsize)
  PAGE_SIZE=$(vm_stat | awk '/page size of/ {print $8}')
  pages_mb() { vm_stat | awk -v ps="$PAGE_SIZE" -v key="$1" \
      '$0 ~ key {gsub(/\./,"",$NF); printf "%.0f", $NF*ps/1048576}'; }
  echo "Total        : $((TOTAL_BYTES / 1048576)) MB"
  echo "Free         : $(pages_mb 'Pages free') MB"
  echo "Active       : $(pages_mb 'Pages active') MB"
  echo "Inactive     : $(pages_mb 'Pages inactive') MB"
  echo "Wired        : $(pages_mb 'Pages wired down') MB"
  echo "Compressed   : $(pages_mb 'Pages occupied by compressor') MB"

  echo
  echo "--- Disk usage (df -h) ---"
  df -h /
  echo
  echo "Available disk space on / : $(df -h / | awk 'NR==2 {print $4}')"

  echo
  echo "--- End of report ---"
  echo
} | tee -a "$LOG_FILE"

