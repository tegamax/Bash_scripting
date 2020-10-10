
Using Conditional Statements
*****************************



Using if ... then ... fi
*************************

**
if experssions
then
    command 1
    command 2

fi

**
else can be included to define what happens if expression is not true

if expression
then
    command 1
else
    command 2
fi


**
elif is used to nest a new if statement within the if statement

while if has to be closed with a fi, elif does not need a seperate fi 

if expression 
then
    command 1
elif expression 2
then
    command 2
fi



**
#!bin/bash
if [ -d $1 ]   #This is a typical test case to see if the input is a directory 
then
    echo $1 is a directory     #THis is the output being displayed on the screen. you can use the cat command to write to a file

elif [ -f $1 ] #This is a typical test case to see if the input is a file 
then
    echo $1 is a file
else
    echo $1 is not a file, nor a directory #If this case is met you will receive a ambigious message. #Is not a directory, you have to write code that does perfectly does error handling 
fi

'''
How to run this 
create the file, in this case we will call the file *ifdir*
running the file
ifdir /etc/passwd
ifdir /etc 
'''


Using && and || are the logical AND and OR 
********************************************

use them as a short notation for if  ... then ... fi constructions

when using && , the second command is executed only if the first returns an exit code zero

    [ -z $1 ] && echo $1 is not defined   #This is to check if $1 is empty or not 

when using ||, the second command is executed only if the firse command does not return an exit code 0

    [ -f $1 ] || echo $1 if not a file 



&& and || Examples

#!/bin/bash
[ -z $1 ] && echo no argument provided && exit 2
[ -f $1 ] && echo $1 is a file && exit 0
[ -d $1 ] && echo $1 is a directory && exit 0

#exit 0 meand the operation was successful
#exit 1 means that the operation was not successful
#exit 2 means that the operation was also not successful based on errors

#Exit code 0        Success
#Exit code 1        General errors, Miscellaneous errors, such as "divide by zero" and other impermissible operations
#Exit code 2        Misuse of shell builtins (according to Bash documentation)        Example: empty_function() {} 



modifying this to catch the other exceptions 
#!/bin/bash
[ -d $1 ] && echo $1 is a directory
[ -f $1 ] && echo $1 is a file || echo $1  is not a file, nor a directory   # This catches the exception that says if it is a file or a directory 

'''
[ -f $1 ] --- condition to check if the input is a file
&& echo $1 is a file ---  if that condition returns as true then return this line executes it echoes that the input is a file
|| echo $1  is not a file, nor a directory ---- If the condition is not true it echoes that it is not a file nor a directory,
having in mind that we checked on a previous line if this was a file or a directory
'''
 


 Using For Statements
 **********************

for statements are useful to evaluate a range or series

    for i in something
    do
        command 1
        command 2
    done 


for i in `cat/etc/hosts`; do echo $i; done   #The back tick here is command substitution 


for i in `cat users`; do echo useradd $i; done

for i in {1..5}; do echo $i; done 

it is common to use a variable i in a for loop, but any other variable can be used instead 

for i in `cat rakers`; do echo useradd $i; done 

for i in {200..210}; do ping -c 192.168.122.$i; 2> dev/null && echo 192.168.122.$i is available done
By using the line "2> dev/null" we are redirececting the out put to null, that is it will ortimacally be deleted and not reccorded anywhere, sonce it is not useful

#we may experience quite a different error here as we see that the output is more than we expected 
#standard output not error output 

for i in {200..210}; do ping -c 192.168.122.$i; > dev/null && echo 192.168.122.$i is available done
#By removing the two from that line we see that what we get is only aresponse when the condition is correct which is the goal.


**
Example with For statement

#!/bin/bash
#Script that counts files
echo which directory do you want to count?
read DIR 
cd $DIR
COUNTER=0

for i in *
do 
    counter=$((COUNTER+1))
    #echo I have counted $COUNTERfiles in this directory   #Doing it here will count each file and print it to th screen
done
echo I have counted $COUNTER files in this directory   #Doing it here will give a summary of all the files counted in the directory location 


Using Case statements
*********************


case is used if you\'re expecting specific values

Thee most common examples is in the legacy system V/Upstart nit scripts in /etc/init.d

case $VAR in 
    yes)            #The open braces here shows the end of the first case
    echo ok;;       #The double semicolon here ends the current open cases for that condition
    no|nee)             
    echo too bad;;
    *)              #This symbol '*', pronounced as star. represents every other thing
    echo try again
    ;;
esac                #This ends the case block. 



#!/bin/bash
VAR=$1

case $VAR in 
    yes)            
        echo ok;;      
    no|nee)             
        echo too bad;;
    *)              
        echo try again;;
esac   


:::::::::::::::::::::::::
cd /etc/init.d      :::::
vim network         :::::
:::::::::::::::::::::::::




Using While and Until
*********************

while is used to execute commands as long as a condition is true

until is used to execute commands as long as a condition is false


while | until condition 
do
    command
done


while true; do true: done &   #This will make your system run till it's maximum cpu capacity. what you wan to do is kill the PID(Process ID)



#!/bin/bash
COUNTER=0

while true

do

    sleep 1
    COUNTER=$(( COUNTER + 1 ))
    echo $COUNTER seconds have assed since started this script
done 







#!bin/bash
until users | grep $1 > /dev/null   #The output of the script is redirected to the null directory #
                                    #This command will only evaluate to true when the user logs in 
do 
        echo $1 is not logged in yet
        sleep 5
done

echo $1 has just logged in
mail -s "$1 has just logged in" root < .     #here an email will be sent using the linux internal mail command.
                                            #The mail will be sent to root and it finishes with a '<.' statement

                                            #mail -s hello root
                                            #We should be expecting somethng like this, as the body of the email :
                                            this is the message itself that will be embedded as the body of the email 
                                            . EOT   #This will end the file




Exercise 5
************


*A customer has exported a long list of LDAP usernames. These usernames are stored in the file ldapusers. 
In this file, every user has a name in the format cn=lisa,dc=example,dc=com.
write a script that extracts the username only (Lisa) from all of these lines and write those to a new file.
Based on this new file, create a local user account on your Linux box

*Note: while testing it\'s not a really smart idea to create the users account directly. 
Find a solution that proves that the script works, without polluting your system with many usernames 

Sample usernames:
cn=lisa,dc=example,dc=com
cn=linda,dc=example,dc=com
cn=laura,dc=example,dc=com
cn=Tyrell,dc=example,dc=com
cn=Leshawn,dc=example,dc=com



'''
vim USERACCOUNTS

USRS="User directory"
names="newfiles.txt"
#!/bin/bash

for i in $USRS;

do 
USER=${i%%,*}
USER=${USER#*=}
echo ${USER} >> $names
done

for i in $(cat names)
do 
echo useradd $i
done 
exit 0
'''



Example Solution
#!/bin/bash
#Extract the user names
for i in $(cat ldapusers)
do 
    USER=${i%%,*}
    USER=${USER#*=}
    echo $USER >> users
done

#show that users creation will work
for j in $(cat users)
do 
    echo useradd $j

done 

exit 0
