#!/bin/bash
source './parse_opts.sh' || source '../parse_opts.sh'

VERSION="0.0.1"

# Show the users some usage info
function show_help {
  echo "Usage:"
  echo "$0 [options] [any text]"
  echo -e "\t--help (-h) - Show this message"
  echo -e "\t--version (-v) - Show the version"
  echo -e "\t--name <name> - Say hello to <name>"
  exit
}

parseOpts '-l version,help,name: -o h,v' "$@"   

# Remove the parsed options from $@
set -- "${_parseOpts_cli_args[@]}"

# # parseOpts will set the variable to '1' if it doesn't take further parameters
[[ -v OPTIONS[help] || -v OPTIONS[h] ]] && show_help
[[ -v OPTIONS[version] || -v OPTIONS[v] ]] && echo "Version: ${VERSION}" && exit 

# # If the option takes a parameter, it will be set to the variable.
[[ -v OPTIONS[name] ]] && NAME=${OPTIONS[name]}
[[ -v OPTIONS[n] ]] && NAME=${OPTIONS[n]}

[[ -v NAME ]] && echo "Hello, ${NAME}!"
[[ ! -z ${@} ]] && echo "You said: $@"