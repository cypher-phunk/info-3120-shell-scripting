#!/bin/sh
#
# Clean the list of parameters
# Normalize paths and remove duplicates

process_parameter() {
  # can replace _param with local param if not using POSIX shell
  # CS3043
  # handles all edge cases
  _param=$(echo "$1" | sed -e 's/^:/.:/' -e 's/::/:.:/g' -e 's/:$/:./')
  echo "${_param}"
}

result=""

#######################################
# Main script execution starts here
#######################################
for arg in "$@"; do
  arg=$(echo "${arg}" | tr ' ' ':')
  processed_arg=$(process_parameter "${arg}")
  
  IFS=':'
  for item in ${processed_arg}; do
    if [ -z "${item}" ]; then
      continue
    fi
    
    # check if item is already in result
    case "${result}" in
      "${item}"|"${item}:"|"${item}:"*|*":${item}"|*":${item}:"|*":${item}:"*)
        continue
        ;;
      *)
        if [ -z "${result}" ]; then
          result="${item}"
        else
          result="${result}:${item}"
        fi
        ;;
    esac
  done
  unset IFS
done

echo "${result}"