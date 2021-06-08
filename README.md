# Parse_Opts.sh

## About
This is a simple bash script to push your CLI options into an associative array named `OPTIONS`, giving you easy pragmatic access to your options.

It uses the external `getopt` command to parse short and long options.

## Requirements
* Bash 4.0 or greater
* getopt - Not getopts which is a builtin bash function
  * Ubuntu: provided by util-linux which is likely already installed; `apt install util-linux`
  * Other linux distrobutions: Unsure which packages offer getopts but again, its ikely installed on most standard installations.

## Install
Clone this repository and copy parse_opts.sh into a convenient location.

## Usage
1. Source the file.
```bash
source /path/o/parse_opts.sh
```
2. call the `parseOpts` function with the following arguments in quotes:
    1. getopts options (e.g. `"--long help,version,name: -o h,v,n:"`)
    2. CLI arguments (usually `"$@"`)
3.  Access your options `OPTIONS[help]`, `OPTIONS[h]`, etc

See the below example for more information.

## Example

```bash
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

## echo "Before 'set' command:"
## echo $@

# Remove the parsed options from $@
set -- "${_parseOpts_cli_args[@]}"


## echo "After 'set' command:"
##echo $@

# # parseOpts will set the variable to '1' if it doesn't take further parameters
[[ -v OPTIONS[help] || -v OPTIONS[h] ]] && show_help
[[ -v OPTIONS[version] || -v OPTIONS[v] ]] && echo "Version: ${VERSION}" && exit 

# # If the option takes a parameter, it will be set to the variable.
[[ -v OPTIONS[name] ]] && NAME=${OPTIONS[name]}
[[ -v OPTIONS[n] ]] && NAME=${OPTIONS[n]}

echo "Hello, ${NAME}!"
[[ ! -z ${@} ]] && echo "You said: $@"
```