Substitution Operation

working with substitution operators
***********************************

A substitution operator (also known as a string operator) allows you to manipulate values of variables in an easy way 

    Ensure that variable exist
    Set default values for variables
    catch errors that result from variables that dont exist
    remove portions of variable values


#Substitution Operation examples

${VAR:-word}: if $VAR exist, use its value. If not, return the value "word". This does NOT set the variable

${VAR:=word}: if $VAR exists, use its value. If not, set the default value to "word"

${VAR:?message}: if $VAR exists, show its value, if not display VAR followed by message. If message is omitted, 
the message VAR: parameter null or not set will be shown.

${VAR:offset:length}: if $VAR exists show the substring of $VAR, starting at offset with a length of length 


**
# DATE=       #this sets the variable as empty
# echo DATE

#echo ${DATE:-today}
today
#echo $DATE

**  
#echo ${DATE:=today}
today
# echo $DATE
today 

**
#DATE=
#echo ${DATE:?variable not set}
-bash: DATE: variable not set 
#echo $DATE

**
#DATE=$(date +%d-%m-%y)
echo the day is ${DATE:0:2}   # Try ${DATE:6:5}
the day is 30



why use pattern matching operators:
***********************************

Pattern matching is used to remove/extract patterns from a variable

It is an excellent way to clean up variables that have too much information 

    *For example, if $DATE contains 05-01-15 and you just need today\'s year
    *Or if a file has the extension *.doc and you want to rename it use the extension *.txt


Pattern Matching explanation

**
${VAR#pattern}: #Search for pattern from the begining of variable\'s value, delete the shortest part that matches and return the rest.

    FILENAME=/usr/bin/bash
    echo ${FILENAME#*/}    # you can use the '*' in this statement or keep it as the results are the same, since it means to match anything before the '/' or nothing before the '/' as in this case.
    response: usr/bin/bash  # in explaining this the '#' means the shortest path that matches and this is the first '/' we see so the '*' says anything before that which is empty and everything after the '/' is echoed out.


 **
 ${VAR##pattern}: #Search for pattern from the begining of the variable\'s value, delete the longest part that matches and return the rest 

    FILENAME=/usr/bin/bash
    echo ${FILENAME##*/} #here the double pound '##' represents the longest match of the symbol '/' ie the last thing that matches that symbol and it returns everything after the last '/'
    response: bash

**
${VAR%pattern}: if pattern matches the end of the variable\'s value, delete the shortest part that matches, and return the rest

    FILENAME=/usr/bin/bash
    echo ${FILENAME%*/}
    response: /usr/bin

**
${VAR%%pattern}: If pattern matches the end of the variable\s value, delete the longest part that matches, and return the rest.

    FILENAME=/usr/bin/bash
    echo ${FILENAME%%/*}


Pattern Matching example script

#!/bin/bash
BLAH=PabaEbarababaraQbaTrara

echo BLAH is $BLAH
echo 'The result of ##*ba is' ${BLAH##*ba}  # Result is 'Trara'
echo 'The result of #*ba is'  ${BLAH#*ba}   # Result is 'EbarababaraQbaTrara'
echo 'The result of %%ba* is' ${BLAH%%ba*}  # Result is 'Pa'
echo 'The result of %ba* is'  ${BLAH%ba*}   # Result is 'PabaEbarababaraQ'


Understanding Regular Expressions
**********************************

Regular expression are search patterns that can be used by some utilities (grep and other test processing utilities, awk,sed)
GREP: Generic Regular Expression Parser   # It works well with SED and AWK
AWK:    
SED 

Regular Expression is NOT the same as wildcards
when using regular expressions, put them between strong quotes so that the shell won\'t interprete them



Regular Expression  |   Use
^text               |   Line starts with text
text$               |   Line ends with text
.                   |   Wildcard (Matches any single character)
[abc],[a-c]         |   Matches a,b or c
*                   |   Matches 0 to an infinite number of previous character
\{2\}               |   Matches exactly 2 of the previous character
\{1,3\}             |   SMatches a minimum of 1 and a maximum of 3 of the previous character
colou?r             |   Matches 0 or 1 of the previous character (Which makes the previous character optional)



Bash Calculating
****************


Bssh offers different ways to calculate in a script

Internal calculation: $(( 1+1 ))

External calculation will let:

#!/bin/bash
# $1 is the first number
# $2 is the operator
# $3 os the second number

let x="$1 $2 $3"   #Not the most efficient way to do a calculation 
echo $x

External calculation with bc (Bash Calculation)


Using bc

bc is developed as a calculator with it\s own shell interface
It can deal with more than just intergers
Use bc in non-interractive mode:

    echo "scale=9; 10/3" |bc

Or using it in a variable:
    VAR=$(echo "scale=9; 10/3"|bc)



Shell Example:
**************

Write a script that puts the result of the command date +%d-%m-%y in a variable. Use Pattern Matching on this variable to show 3 lines,
displaying the date, month and year. So the result should look as follows:

The day is 05
The month is 01 
The year is 15


#First solution 

#!/bin/bash
#Script to format the date.

DATE=$(date +%d-%m-%y)

echo "The day is ${DATE:0:8}"
echo "The month is ${DATE:3:2}"
echo "The year is ${DATE:6:2}"

exit 0




#Second solution 
#Using command substitution

DATE=$(date +%d-%m-%y)

echo the day is ${DATE%%-*}
MONTH=${DATE%-*}     #The result here will be the month and the day because we cannot grab anything in the middle of the string so we do that 
echo the month is ${MONTH#*-}   #The next is that we then grab the real value we need.
#YEAR=${DATE##*-}
echo the year is ${DATE##*-}



