

Using the grep utility
**********

grep is a very flexible tool to search for text patterns based on regular expressions

    grep -i: case insensitive
         grep -i what*

    grep -v: exclude lines that match the pattern
        grep -v what*
    
    grep -r: recursive
        grep -r what*

    grep -e (egrep): matches more regular expressions
        grep -e  'what' -e 'else'*

    grep -A5: shows 5 lines after the matching regex

    grep -B4: shows 4 lines before the matching regex


Try this
grep -i -e date -e year *



Using Test
**********

test allows for testing of many items

    Expression: test (ls /etc/hosts)

    string: test -z $1   #Test to see if the variable is empty or not

    intergers: test $1 = 6  #to check if the variable has avery specific value

    file comparisons: test file1 -nt file2    #nt stands for (newer than). This allows you copy a file if the the new file is newer than the old file

    file properties: test -x file1  # This is used to check file properties using the (ls) command



Three ways to test

test -z $1: Old method, using an internal bash command

[ -z $1 ]: This is equavalent to test using the bash internal

[[ -z $1 ]]: new improved versin of [ ... ] Not as universal as [ ... ]; it has && and || built in 

Best pratice: If it doesn\'t work using [ ... ], try using [[ ... ]]

If compatibility with older shells doesn\'t matter, use [[ ... ]]

Compare the following:

BLAH=PabaEbarababaraQbaTrara

    [ $BLAH = a* ] || echo string does not start with a    #The strictness regardarding syntax is very true here. 
                                                            #you have to remove the whitespaces around the operators
    [[ $BLAH = a* ]] || echo string does not start with a  


Using cut and sort
********************

cut -f 1 -d : /etc/passwd     # -f 1 for field number one and d for delimiter:  you can use | sort | head to organize the cut results

sort /etc/passwd 

cut -f 3 -d: /etc/passwd | sort -n    #the n here means a numeric sort, without the sort it takes in the number as it finds it in the ASCII table 

du -h | sort -rn     #rn #reverse numeric sort #-h # gives the size of all the directories in that directory location

sort -n -k3 -t: /etc/passwd   #This is sorting but not cutting anything out. # The k3 means that it is sorting on column 3.  
                              #on the -t as the filter delimiter, where the lowest or the highest username is mentioned first  


sort -n -r -k3 -t: /etc/passwd   #The -r you see here is for a reverse. the sort command is relatively easier to implement than sorting in other utilies like awk and sed 



Using Tail and Head 
*******************


tail is used to display the last line(s) of the file

head is used to display the first line(s) of the file   #If the line is not specified it takes 10 lines by default

tail -2 /etc/passwd  #This takes the 2nd line

head -2 /etc/passwd  

head -5 /etc/passwd | tail -2   #This takes the first five lines and then the tail -1 takes the last line of this feed


Using Sed 
*********
This is a programming language

sed is more than a text processing utility, it is a programming llanguage with many features

A limited set of these are useful in scripts

sed -n 5p /etc/passwd   #THis shows line number 5 and prnts it 

sed -i s/old-text/new-text/g ~/myfile 

sed -i s/hello/bye/g ~/myfile # Here we are doing string substitution inside the file named ~/myfile. The g is for global, the i is for writing to the file
                              #whenever we will substitute it for bye. which is a generic way for substituting.

sed -i -e '5d' ~/myfile  #-i sor interractively, so it writes immediately.  -e for edit , and then 5d, meaning that we want to delete line 5 from the file

sed -i -e '2d;20,25d' ~/myfile    #Here the sed will delete line 2 and also delete from line 20 to 25 


Using awk
*********

Like sed, awk is a very rich language 

In scripts you\'ll appreciate it as an alternative to cut to filter information from text files based on regular expression-based patterns

The basic usage is awk '/search pattern/ {Actions}'file 


awk -F : '{ print $4 }' /etc/passwd   #Prints the 4th column of the file

awk -F : '/user/ { print $4 }' /etc/passwd  # the search pattern here is the user 

awk -F : '{ print $1,$NF }' /etc/passwd ($NF is the last field)  # $NF  here reffers to the last fiels. and $1 is the first field

awk -F : '$3 > 500' /etc/passwd     # this evaluates if the value from $3 is greater than 500 

awk -F : '$NF ~/bash/' /etc/passwd    #we are looking at the last script to compare to the main if it contains bash or not then print it out 



Using tr (Translate)
*******


tr helps in transforming strings

echo hello | tr [a-z][A-Z]   #This is to catch all strings

echo hello | tr [:lower:] [:upper:]    #This is the same as giving the strings in literal 



Chapter Assignment:

Create a script that transforms the string 
cn=lara, dc=example,dc=com in a way that the user name (lara) is extracted from the string.
Also make sure that the result is written in all lowercase. Store the username in the variable USER and at the end of the script,
echo the value of this variable. 



make a file with the usernames
extrace the usernames using sed command (awk -F : '{ print $4 }' /etc/passwd)
then do a for loop at the end of the script,
this will print each of the entries to screen 



#!/bin/bash

USER=cn=lara,dc=example,dc=com

USER=${USER%%,*}

USER=${USER#*=}

USER=$(echo $USER | tr [:lower:] [:upper:])

echo the username is $USER

