#!/bin/bash
#
# Find the full path of the command

FINDALL=false
if [[ $1 == "-a" ]]; then
	FINDALL=true
	shift
fi

for file in "$@"; do
	FOUND=false
	# direct path
	if [[ ${file} == */* ]]; then
		# exe and not directory
		if [[ -x ${file} ]] && [[ ! -d ${file} ]]; then
			echo "${file}"
		else
			echo "${file} not found"
		fi
	else
		path_string="${PATH}:"
		while [[ -n ${path_string} ]]; do
			dir=${path_string%%:*}
			path_string=${path_string#*:}

			# empty dir case
			if [[ -z ${dir} ]]; then
				dir="."
			fi

			if [[ -x "${dir}/${file}" ]] && [[ ! -d "${dir}/${file}" ]]; then
				echo "${dir}/${file}"
				FOUND=true
				if [[ ${FINDALL} == false ]]; then
					break
				fi
			fi
		done

		if [[ ${FOUND} == false ]]; then
			echo "${file} not found"
		fi
	fi
done
