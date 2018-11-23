#!/usr/bin/env bash

[[ -z $OS ]] && OS="$(uname -s)"

if [[ $OS = "Darwin" ]] && [[ -z $HARDWARE ]]; then
  HARDWARE="$(/usr/sbin/system_profiler SPHardwareDataType | awk '{ if (NR == 5) print $3}')"
fi

function load_avg() {
  echo "[load_avg:#[fg=white] $(uptime | awk '{print $(NF-2)}')#[default]]"
}

function battery_level() {
  if [[ "$OS" = "Darwin" ]] || [[ "$HARDWARE" = "MacBook" ]]; then
    local battery_info=$(/usr/bin/pmset -g ps | awk '{ if (NR == 2) print $3 " " $4 }' | sed -e "s/;//g" -e "s/%//")
    if [[ -n $battery_info ]]; then
      local battery_quantity
      local battery
      battery_quantity=" $(echo $battery_info | awk '{print $1}')"
      if [[ ! $battery_info =~ "discharging" ]]; then
        battery="#[fg=white] +$battery_quantity%#[default]"
      elif (( $battery_quantity < 20 )); then
        battery="#[bg=red,fg=white]$battery_quantity%#[default]"
      else
        battery="#[fg=white]$battery_quantity%#[default]"
      fi
    fi
  fi
  echo "[battery:$battery]"
}

function main() {
  local lavg=$(load_avg)
  local battery=$(battery_level)
  echo "${lavg} ${battery}"
}

main $@
