#!/bin/bash

##### This is comment
echo "Comment" # This is comment to
	# One more comment

##### Semikolon ';'
echo "one" ; echo "two"

##### Double semocolon ';;'
var=2``
case "$var" in
1) echo "var = one" ;;
2) echo "var = two" ;;
esac

##### Dot '.' and source
. data-file_1			# Add data file
source data_file_2		# Add data file
echo "var_1 = $var_1"
echo "var_2 = $var_2"
echo "var_3 = $var_3"
echo "var_4 = $var_4"

##### Double quotes ""
echo "First example $var_1"

##### Single quotes ''
echo 'Second example $var_1'

##### Comma ','
let "t2 = ((a = 2), 12 / 4)"
echo "t2 = $t2; a = $a"

##### Colon ':'
:						# Return true or 'do nothing'
echo $?

while :					# Endless cycle
do
	echo "one"
	echo "two"
	:					# do nothing
	if [ : ]
	then
		break
	fi
done

: ${HOSTNAME?} #${LFS?}	# If parameter not set - return error

: > file_name			# Create or clean file (cat /dev/null > file_name)

: >> file_name			# Create file_name if not exist or nothing

# : This is comment about error, ( if [ : ] )		# Create comment

echo $PATH

##### Inversion '!'
if [ ! : ]
then
	echo "Comment_1"
else
	echo "Comment_2"
fi

##### Template '*'
echo *

##### Double star '**'
let "s = $a**2"				# Exponentiation
echo  "a = $a; s = $s"

##### Question mark '?'
(( m = s<2?13:22 ))
echo "m = $m"

##### Dollar sign '$'
echo $m 					# Get m value

##### Parameter substitution
echo ${username-`whoami`}	# Get username or exec whoami comand

##### CLI parameter '$*' '$@' '$#' '$-'
echo "Argumets number = $#"			# Arguments numbers
echo "First args = $0"				# First arg
echo "Second args = $1"				# Second ...
echo $*								# All args in one str
echo "$@"							# Every arg in each str !!! USE WITH DOUBLE QUOTES ONLY
echo $-								# Show bash options
echo "123" "333"
echo $_ 							# Last arg last entered comand -> '333'
sleep 2 &
echo $!								# PID for last background process
echo $?								# Last returned result
echo $$								# PID this script

##### Parentheses ()
(									# This block execute in child process. It is isolated
	a="best"
	echo "first a = $a"
	echo "second"
)
echo $a
Array=("One" "Two" "Three")
index=1
for el in "$Array"
	do echo "$index = $el"
	let "index+=1"
done

##### Braces {}
# grep Linux file1.{txt,htm}		# Search "linux" in 'file1.txt' and 'file1.htm'
# !!!!! Use spaces in baces forbidden
# grep Linux file1,{txt, htm}					=> ERROR
# grep Linux file1,{\ txt," htm",' html'}		=> SUCCESS
{									# This block execute in child process. It is not isolated
	a="slow"
	echo "first a = $a"
	echo "second"
}
echo $a
{									# One more example
	echo "more more data"
	echo "and one more data"
} > output_file

E_BADARGS=65
if [ ! -n "$1" ]
then
	echo "Порядок использования: `basename $0` argument1 argument2 и т.д."
	exit $E_BADARGS
fi
echo
index=1
echo "Список аргументов в переменной \"\$*\":"
for arg in "$*" # Работает некорректно, если "$*" не ограничена кавычками.
	do echo "Аргумент #$index = $arg"
	let "index+=1"
done # $* воспринимает все аргументы как одну строку.
echo "Полный список аргументов выглядит как одна строка."
echo
index=1
echo "Список аргументов в переменной \"\$@\":"
for arg in "$@"
	do	echo "Аргумент #$index = $arg"
	let "index+=1"
done # $@ воспринимает аргументы как отдельные строки (слова).
echo "Список аргументов выглядит как набор различных строк (слов)."
echo

echo "$@" # 1 2 3 4 5
shift					# Erase first arg
echo "$@" # 2 3 4 5
shift
echo "$@" # 3 4 5
# Каждая из команд "shift" приводит к потере аргумента $1,
# но остальные аргументы остаются в "$@".

# Демонстрация противоречивости содержимого внутренних переменных "$*" и "$@",
#+ которая проявляется при изменении порядка заключения параметров в кавычки.
# Демонстрация противоречивости, проявляющейся при изменении
#+ содержимого переменной IFS.
set -- "Первый один" "второй" "третий:один" "" "Пятый: :один"
# Установка аргументов $1, $2, и т.д.
echo
echo 'IFS по-умолчанию, переменная "$*"'
c=0
for i in "$*" # в кавычках
do echo "$((c+=1)): [$i]" # Эта строка остается без изменений во всех циклах.
# Вывод аргументов.
done
echo ---

echo 'IFS по-умолчанию, переменная $*'
c=0
for i in $* # без кавычек
do echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS по-умолчанию, переменная "$@"'
c=0
for i in "$@"
do echo "$((c+=1)): [$i]"
done
echo ---

# echo 'IFS по-умолчанию, переменная $@'
# c=0
# for i in $@
# do echo "$((c+=1)): [$i]"
# echo ---

IFS=:
echo 'IFS=":", переменная "$*"'
c=0
for i in "$*"
do echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", переменная $*'
c=0
for i in $*
do echo "$((c+=1)): [$i]"
done
echo ---

var=$*
echo 'IFS=":", переменная "$var" (var=$*)'
c=0
for i in "$var"
do echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", переменная $var (var=$*)'
c=0
for i in $var
do echo "$((c+=1)): [$i]"
done
echo ---

var="$*"
echo 'IFS=":", переменная $var (var="$*")'
c=0
for i in $var
do echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", переменная "$var" (var="$*")'
c=0
for i in "$var"
do echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", переменная "$@"'
c=0
for i in "$@"
do echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", переменная $@'
c=0
for i in $@
do echo "$((c+=1)): [$i]"
done
echo ---

var=$@
echo 'IFS=":", переменная $var (var=$@)'
c=0
for i in $var
do echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", переменная "$var" (var=$@)'
c=0
for i in "$var"
do echo "$((c+=1)): [$i]"
done
echo ---

var="$@"
echo 'IFS=":", переменная "$var" (var="$@")'
c=0
for i in "$var"
do echo "$((c+=1)): [$i]"
done
echo ---

echo 'IFS=":", переменная $var (var="$@")'
c=0
for i in $var
do echo "$((c+=1)): [$i]"
done
echo
# Попробуйте запустить этот сценарий под ksh или zsh -y.

# Если переменная $IFS инициализирована "пустым" значением,
# то "$*" и "$@" содержат аргументы не в том виде, в каком ожидается.
mecho () # Вывод аргументов.
{
	echo "$1,$2,$3";
}
IFS="" # Инициализация "пустым" значением.
set a b c # Установка аргументов.
mecho "$*" # abc,,
mecho $* # a,b,c
mecho $@ # a,b,c
mecho "$@" # a,b,c
# Поведение переменных $* и $@, при "пустой" $IFS, зависит
# от версии командной оболочки, Bash или sh.
# Поэтому, было бы неразумным пользоваться этой "фичей" в своих сценариях.

