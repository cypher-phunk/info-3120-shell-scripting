#!/usr/bin/bash
#
# Rename files and directories with spaces in their names

USAGE="$0 -f directory
$0 -d  directory
$0 -d -f directory

-f rename files 
-d rename directories 
"

usage()
{
  echo  "${USAGE}"
  exit 1
}

pathname()
{
  echo  "${1%/*}"
}

basename()
{
  echo  "${1##*/}"
}

find_dirs()
{
  find "$1" -depth -type d -name '* *' -print
}

find_files()
{
  find "$1" -depth -type f -name '* *' -print
}

#######################################
# Rename files and directories with spaces in their names
# Globals:
#   None
# Arguments:
#   $1 - directory
# Returns:
#   None
#######################################
my_rename() {
  # 1. Check if the directory where $1 resides is writeable
  PARENT_DIR="$(dirname "$1")"
  if [[ ! -w "${PARENT_DIR}" ]]; then
    echo "Error: Directory '${PARENT_DIR}' is not writeable." >&2
    return 1
  fi

  # 2. Check if "$2" exists
  if [[ -e "$2" ]]; then
    echo "Error: '$2' already exists." >&2
    return 1
  fi

  # 3. Perform the rename operation
  if ! mv "$1" "$2"; then    
    echo "Error: Failed to rename '$1' to '$2'." >&2
    return 1
  fi

  echo "Renamed: '$1' to '$2'"
  return 0
}

#######################################
# Fix directories with spaces in their names
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
#######################################
fix_dirs()
{
  # shellcheck disable=SC2312
  find_dirs "$1" | while read -r dir; do
    dir_name="$(basename "${dir}")"
    parent_dir="$(dirname "${dir}")"
    
    new_name="${dir_name// /-}"
    
    if [[ "${dir_name}" != "${new_name}" ]]; then
      my_rename "${dir}" "${parent_dir}/${new_name}"
    fi
  done
}

#######################################
# Fix files with spaces in their names
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
#######################################
fix_files()
{
  # shellcheck disable=SC2312
  find_files "$1" | while read -r file; do
    file_name="$(basename "${file}")"
    parent_dir="$(dirname "${file}")"
    
    new_name="${file_name// /-}"
    
    if [[ "${file_name}" != "${new_name}" ]]; then
      my_rename "${file}" "${parent_dir}/${new_name}"
    fi
  done
}

#######################################
# Main script execution starts here
#######################################
WFILE=
WDIR=
DIR=

if [[ "$#" -eq 0 ]]; then
  usage
fi

# Parse command line options
while [[ $# -gt 0 ]]; do
  case $1 in
  -d)
    WDIR=1
    ;;
  -f)
    WFILE=1
    ;;
  -*)
    usage 
    ;;
  *)
    if [[ -d "$1" ]]; then
      if [[ "$1" == "." || "$1" == ".." ]]; then
        echo "Error: Cannot use . or .. as the directory."
        exit 1
      fi
      
      REAL_PATH=$(realpath "$1")
      CURRENT_DIR=$(realpath ".")
      if [[ "${REAL_PATH}" == "${CURRENT_DIR}" ]]; then
        echo "Error: Cannot use current directory."
        exit 1
      fi
      
      DIR="$1"
    else
      echo "$1 does not exist ..."
      exit 1
    fi
    ;;
  esac
  shift
done

if [[ -z "${DIR}" ]]; then
  echo "Error: Directory not specified."
  usage
fi

# Check if both -f and -d are not specified
if [[ -z "${WDIR}" ]] && [[ -z "${WFILE}" ]]; then
  echo "Error: Must specify at least one of -f or -d."
  usage
fi

# Perform the necessary operation based on flags
if [[ -n "${WDIR}" ]] && [[ -n "${WFILE}" ]]; then
  fix_files "${DIR}"
  fix_dirs "${DIR}"
elif [[ -n "${WDIR}" ]]; then
  fix_dirs "${DIR}"
elif [[ -n "${WFILE}" ]]; then
  fix_files "${DIR}"
fi