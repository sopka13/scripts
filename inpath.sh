#!/bin/bash
# inpath - Checks if the path to the specified program is valid

in_path()
{
	# Get command and path and check this command
	# return 0 - Success. This command exists.
	# return 1 - Faill. Command not found
	cmd=$1
	our_path=$2
	result=1

	for directory in $our_path
	do
		echo $directory
		if [ -x $directory/$cmd ] ; then
			result=0
		fi
	done

	return $result
}

check_for_cmd_in_path()
{
	var=$1

	if[ "$var" != "" ] ; then
		if[ "${var:0:1}" = "/" ] ; then
			if[ ! -x $var ] ; then
				return 1
			fi
		elif ! in_path $var "$PATH" ; then
			return 2
		fi
	fi
}