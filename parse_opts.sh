#!/bin/bash
declare -A OPTIONS
declare -a _parseOpts_cli_args

function parseOpts {
  declare match_pattern="'([^']+)'"
  declare key
  declare params=$1
  shift
  declare opts
  opts=$(getopt $params -- "$@")
  [[ $? -eq 0 ]] || exit 1
  opts=(${opts})
  for (( i=0 ; i < ${#opts[@]} ; i++ )) do
    if [[ ${opts[$i]} == "--" ]]; then
      let i++
      _parseOpts_cli_args=(${opts[@]:$i})
      break
    fi
    key=`expr match "${opts[$i]}" '--\?\(.*\)'`
    OPTIONS[${key}]=1

    # Assign key-value pairs
    if [[ "${opts[$i+1]}" =~ $match_pattern ]]; then 
      OPTIONS[${key}]=${BASH_REMATCH[1]}
      let i++
    fi
  done
  
  # Strip the quotes getopt puts on extra arguments
  for ((i=0; i < ${#_parseOpts_cli_args[@]};i++ )) do
    if [[ "${_parseOpts_cli_args[$i]}" =~ $match_pattern ]];then
      _parseOpts_cli_args[$i]=${BASH_REMATCH[1]}
    fi
  done

}
