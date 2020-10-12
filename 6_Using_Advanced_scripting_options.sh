
#Using Options

An option is an argument that changes the script behavior

Oprions are not often used in scripts

getops is used to deal with Options


#!bin/bash
#script that creates users using perferred options
#Usafe: use -a to add a home directory
#       use -b to make the user member of group 100
#       use -c to specify a custom shell. This option is followed by a shell name


while getops "abc:" opt   # the column behind c means that c takes an option. #opt is the variable that is to be evaluated and this happens in the case loop
do 
case $opt in                #This defines the different options. Option A, B ,C 
        a) VAR1=-m ;;
        b) VAR2="-g 100" ;;   #It is advisable to use quotations for the entire value because of the space between the assigned characters
        c) VAR3="-s $OPTARG";;   #optarg is a fixed argument, it provides the option in it. thus it will take the first option after the column sign ':'
        *) echo 'usage: makeuser [-a] [-b] [-c shell] username'
    
esac    #The case is closed here 
done    #The while loop is closed here 

echo the current arguments are set to $*    # $* is All the values that have been used  
shift $ (( OPTIND -1 ))                     #this is a special variable that refers to the option index and we will substract one from it 
                                            #The optint here removes all the arguments that an option but will only keep the one that will be used.
echo now the current arguments are set to $*
echo useradd $VAR1 $VAR2 $VAR3 $1           # $1 is the first argument that is not an option 
exit 0

'''
How to run
***********

#makeuser -a -b lisa
the current arguments are set to -a -b lisa
now the current arguments are set to lisa
useradd -m -g 100 lisa



#makeuser -a -b -c /bin/bash lisa
Results:
the current arguments are set to -a -b -c /bin/bash lisa
now the current arguments are set to lisa
useradd -m -g 100 -s /bin/bash lisa
'''



Functions
*********

Functions are useful if code is repeated frequently
Functions must be defined before they can be used
it is good pratice to define all functions at the begining of a script 
syntax approach 1:

function help                       # Start with the word function and the name of the function 
{
    echo this is how you do it      #Then you define the code within the given function 
}

'''
Function must be defined before they are used. 
It is advisable to define the functions at the begining of the script but it is not absolutely necessary that this happens 
start the script with the list of all the varriables and a list of all the functions
'''


Syntax approach 2:
help ()         #Define the name of the function with curly braces then include the function contents within the function as expected
{
    echo this is how you do it
}


Using Functions: Simple Example

#!/bin/bash
noarg()
{
    echo you have not provided an argument
    echo when using this script, you need to specify a filename
    exit 2
}


if [ -z $1 ]; then
        noarg
else
        file $1
fi 
exit 0


'''
running this
# easyfunction                      #This will throw up an error saying that an argument was not given 
#easyfunction blah                  #This will return an error saying that the blah is not a filename of that the file cannot be found in the directory 
#bash -x easyfunction bash          #This will debug the function line by line and display the result logs on the screen
#easyfunction /etc/hosts            #Result:  /etc/hosts: ASCII text
'''



Working with Arrays:
*******************

Nothe that Bash also follows the zero-based indexing just as python and java

An array is a string variable that can hold multiple values 

Although appreciated by some, using arrays can often be avioded because modern bash can contain multiple values in a variable as well

The amount of values that can be be kept in arrays is higher, which makes them useful in some cases anyways

The downpart is that Bash arrays are relatively complicated 

**
Using Arrays example:

names=(linda lisa laura lori)
names[0]=linda
names[1]=lisa
names[2]=laura
names[3]=lori
echo ${names[2]}
echo ${names[@]}   #This will show everything in the array
echo ${#names[@]}   #The hash symbol will count everything in the variable. the response here will be 4
echo ${names}       #note that this will only collect the first value from the array

variable assignment:
*******************
names[4]=lucy #This will assign the argument lucy to the names array 




Defining/Creating  Menu Interfaces:
***********************************

The select statement can be used to create a menu Interface

    select DIR in /bin /usr /etc 

In this, DIR is the variable that will be filled with the selected choice, and /bin /usr /etc are presented as numbered menu options

Notice the use of break in select, without it the script would run forever 



Menu Interfaces Example

#!/bin/bash
# demo script that shows making menues with select 


echo 'Select a directory: '    #Remember this is between single quotes
select DIR in /bin /usr /etc 
do

    #only continue if the user has selected something
    if [ -n $DIR ]
    then
        DIR=$DIR
        echo you have selected $DIR
        export DIR
        break
    else
        echo invalid choice
    fi
done




Example 2
**********


#!/bin/bash
#Sample Administration Menu


echo 'select a task: '
select TASK in 'Check mounts' 'Check disk space' 'Check Memory usage'
do

    case $REPLY in 
            1) TASK=mount;;
            2) TASK="df -h";;
            3) TASK="free -m";;
            *) echo ERROR && exit 2;;
    esac 
    if [ -n "$TASK" ]
    then
            clear
            $TASK 
            break
    else 
            echo INVALID CHOICE && exit 3

    fi 
done 





Using Trap
**********

Trap can be used to redefine signals

Useful to disallow Ctrl-C or other ways of killing a script

Consult man 7 signal for a list of available signals

checking the manpages 
man 7 signal 


Example with trap 

#!/bin/bash
# The uninterruptable script

trap "echo 'Forget it bro!' " INT 

trap "logger  'Who tried to kill me?' " KILL

trap "logger  'Getting nasty huh?' "    TERM

while true

do
    true 

done 



Exercise 6
**********

Create a user helpdesk. Write a menu script that is started automatically when the user logs in.
The menu script schould never be terminated, unless the user logs out (Which is a menu option as well). 
From this menu, make at least the following options available:
(1) Reset Password,
(2) Show disk usage,
(3) Ping a host, 
(4) Log out 

Bonus Question:
modify this script and relate configuration so that the user can use sudo to set passwords for other users as well



Exercise 6 Solution
*******************

#!/bin/bash
while true ; do                 #We want a script that will never end

        trap "echo NOPE" INT       #this is where the user is trying to ctrl-c his way out of the script . The response will be no
        pinghost ()                #The function ping host 
        {
                echo which host \do you want to pinghost
                read HOSTNAME
                ping -c 1 $HOSTNAME
        }
        echo 'Select option: '
        select TASK in 'change password' 'monitor disk space' 'ping a host' 'logout'
        do
                case $REPLY in
                        1) TASK=passwd;;
                        2) TASK="df -h";;
                        3) TASK=pinghost;;
                        4) TASK=exit;;
                esac

                if [ -n "task" ]
                then

                        $TASK
                        break
                else
                        echo invalid choice #, try again
                fi
        done
done

'''
The double semicolon is also useful as it leaves no ambiguity in the code. 
It is required as it is used at the end of each clause as required by the bash syntax in order to parse the command correctly. 
It is only used in case constructs to indicate that the end of an alternative.
'''
    
        