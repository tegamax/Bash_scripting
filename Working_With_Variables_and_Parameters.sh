
#Working_With_Variables_and_Parameters.sh


#Quoting

#About terminology
***************

An Argument is anything that can be used after a command 
ls -l /etc   #This has two arguments

An option is an argument that was specifically developed to change the command behavior

A parameter is a name that is defined in a script to which a specific value is granted

A variable is a label that is sorted in memory and contains a specific value

#Using and Defining Variables
***********************

#Using Variables: An Example


#!/bin/bash
#This is a script that copies /var/log contents and clears current contents of the file
#usage: ./clearlogs

LOGFILE=/var/log/messages   #It is not mandatory to use upper or lowercase to define variables, But it is recommended as a best pratice to use CAPS
cp $LOGFILE $LOGFILE.old
cat /dev/null > $LOGFILE
echo log file copied and cleaned up

exit 0



#Defining Variables in general
*********************************


There are three ways to define variables
    Static: VARNAME=value

    As an argument to script, handled using $1, $2 etc, within the script

    Interactively using read 

Best pratice is to use uppercase only for variable names


##echo $COLOR           # An empty line in the preceding result shows that the variable is not yet set

##COLOR=blue            # This will only make the variable in the current shell
##echo $COLOR           # The result here should be blue

##bash
##echo $COLOR           # This will return a blank because the variable is not declared in the subshell as well


##exit
##echo $COLOR           # The result here will be blue as the variable was decleared here

***
#Using the export command 

##export COLOR=red       # This will make the declearation present on both the terminal and all the sub-terminals

##echo $COLOR            # The response here should be red

##bash
##echo COLOR            # The color here should be red as we see that the the variable is now being decleared in all the locations. It will be available outside the script where the script exist


#Defining variables with the read command
*******************************************


#!/bin/bash
#
#Ask what to stop using the kill command and then kill it

##echo which process do you want to kill?
##read TOKILL

##kill $(ps aux | grep $TOKILL | grep -v grep | awk '{print $2}')    #This is called command substitution

'''
This structure is called the command substitution and the kill command requires a process ID which is filtered out of the command.

'''

ps aux | grep http | awk '{print $2}'  # the awk command here is getting the second column of PIDs


ps aux | grep http | grep -v grep | awk '{print $2}'  # the grep -v grep command will filter out all grep false positives commands

ps aux | grep http   #checking with this command shows that we have killed the targeted processes 

bash -x tokill # this will show every line that gets executed will be printed to the screen

systemctl start httpd  #This starts a command that will be killed by the 'tokill' script


#
The read command will stop the script until the user enters a confirmation on the screen

If an argument is not provided to read, this argument will be treated as a variable and the entered value is stored in the variables

    Multiple arguments can be provided to enter mutiple variables
    use read -a somename to write all words to an array with the name somename
If no input is provided, the script will just pause until the user presses the Enter key





#Understanding Variables and Subshells
**************************************


A variable is effective only in the shell where it was defined

use export to make it also available in subshells (downwards)

There is no way to make variables available in parent shells (If you want the variable to be avaiable in the parent shell, then decleare it there.)



#!/bin/bash
#
# showing variable use between shells

echo which directory do you want to activate
read DIR 

cd $DIR
pwd       #prints the name of the current directory
ls        #prints the contents of the current directory

exit 0  # This exits the subdirectory to the parent shell



How to define the variables at the start of a shell/file 

/etc/profile is processes when opening a login shell

    *All variables defined here are available in all subshells  for that specific user
    * User specific versions can be used in ~/.bash_profile

/etc/bashrc is processes when opening a subshell

    *Variables defined here are included in subshells from that point on
    *User specific versions can be used in ~/.bashrc



#Sourcing 
*********

By using sourcing, the contents of one script can be included in another script

This is a very common method to seperate static script code from dynamic content
    *This dynamic content consist of variables and functions

Use the source command or the . command to source scripts

Do NOT use exit at the end of a script that needs to be sourced 



Master Script

#!/bin/bash 
# Example script to show how sourcing works

.  /root/sourceme

echo the value of the variable '$COLOR' is $COLOR       #The single quote here tells the shell not to interprete it's contents but just to show the contents of the single quotes

exit 0

Input script /root/sourceme

COLOR=red

#vim /etc/rc.d/init.d/functions   # This shows all the working functions that are currently in the init parent directory




#Quoting
********

The bash shell uses different special characters


Character   |   Meaning
~           |   Home directory
`           |   Command Substitution`
#           |   Comment
$           |   Variable Expression
&           |   Background job
*           |   String Wildcard
(           |   Start Subshell
)           |   End subshell
\           |   Quote next character
|           |   pipe        #This means the output for command 1 chosses the input for command 2
[           |   Start character set Wildcard
]           |   End characterr Wildcard
{           |   Start command block
}           |   End Command block
;           |   Shell command seperator 
'           |   Strong Quotes
"           |   Weak Quote
<           |   Input Quote
>           |   Output Quote
/           |   Pathname directory seperator 
?           |   Single character wildcard
'

When a command is interpreted by the shell, the shell interprets all special characters
    The process is known as command line parsing

Commands themselves may interprete parts of the command line as well
To ensure that a special character is interpreted by the command and not by the shell use quoting

Quoting is used to treat special characters literally

Hence if a string of characters is surrounded with single quotation marks, all characters are stripped of the special meaning they may have

    Imagine echo 2 *3 > 5, which ensures that find interpreted  #this will place the numbers 2 and 3 into the location 5 and it will treat 5 as a directory.
    #cat 5 will contail values 2 and 3 . but when using echo '2 * 3 > 5' you will get the literal from that.
    Or imagine find .-name '*.doc' which ensures that find interprets *.doc and not the shell #Here the find command will find the string within the quotes
Double quotess are weak quotes and treat only some special characters as special

A backslash can be used to escape the one following character 


Double quotes ignore pipe characters, aliases, tilde substitution, wildcard expression, and splitting into words using delimiters

Double quotes do allow parameter substitution, command substitution, and arithemetic expression evaluation

Best Pratice: use single quotes, unless you specifically need parameter, command, or arithmetic substitution


#Handling Script arguments
*************************


Any argument that was used when starting a script, can be dealth with from within the script

Use $1, $2 and so on to refer to the first, the second, etc. argument

$0 refert to the name of the script itself

Use ${nn} or shift to refer to arguments beyond 9

Arguments that are stored in $1 etc are read only and cannot be changed from within the script




Example of argument usage

#!/bin/bash
#
#Simple demo script with arguments
#Run this script with the names of one or more people
'''
This script is a very simple one that only takes in two arguments when running it. But it returns null when there is no argument given 
and truncates when more than than two arguments are given
'''

echo "Hello $1 how are you"
echo "Hello $2 how are you"

exit 0


*Instructions to run on the command line 

vim simpleargument   #then paste the above script from (#!/bin/bash) to the (exit 0) line
chmod +x simpleargument
./simpleargument  Bob Pete #This runs the script with results
#Hello Bob how are you
#Hello Pete how are you


./simpleargument  Bob Pete lisa alex charlie #This truncates the first two arguments and discards the rest. the result will be
#Hello Bob how are you
#Hello Pete how are you

./simpleargument  Bob       #This returns only one item in the result, and leaving the other value as null
#Hello Bob how are you
#Hello  how are you


The previous example works only if the amount of arguments is known before handled

if this is not the case, use for to evaluate all possible arguments

Use $@ to refer to all arguments provided, where all arguments can be treated one by one

Use $# to count the amount of all arguments provided

Use $* if you need a single string that contains all arguments (Use specific cases only)


*Dealing with Arguments

#!/bin/bash
#Script that shows how arguments are handled

echo "\$* gives $*"     #This will get all the values of the arguments
echo "\$# gives $#"     #This will get the count of all the given arguments
echo "\$@ gives $@"     #This will get all the values of the arguments, but this is done one after the other unlike * that does it all in a list or string format
echo "\$0 is $0"        #This will be the name of the script


Showing the interpreatation of \$*

for i in "$*"
do
    echo $i
done

Showing the interpreatation of \$@
for j in "$@"
do 
    echo $j

done
exit 0


*Instructions to run on the command line 

vim nicearguments    #The paste the contents of the code above into the script
chmod +x nicearguments
nicearguments a b c

#The results will now be:

$* gives a b c
$# gives 3
$@ gives a b c 
$0 is /root/bin/nicearg 
a b c
a 
b 
c 



Handling User Input Through Arguments or Input

#!/bin/bash
#Script that shows how to make sure that user input is provided

if [ -z $1 ]  #This is to check (Like run a test) if the given argument is empty or not

then

        echo provide filenames
        read FILENAMES   #when you're using variable to define a variable you don't need to put the dollar "$" symbol in front of it  
else 
        FILENAMES="$@"
    
fi 

echo the following filenames have been provided: $FILENAMES



Understanding the need to use shift
***********************************

#!/bin/bash
#
#Simple demo script with arguments
#Run this script with the names of one or more people
'''
 
'''

echo "Hello $1 how are you"
echo "Hello $2 how are you"
echo "Hello $10 how are you"    #Here we are trying to substitute the entry for the tenth argument #We can also see how the 0 <Zero> in the quote remains as a string 
exit 0


#Running the code, 

simpleargument a b c d e f g h i j 

#the results are:

Hello a how are you
Hello b how are you
Hello a0 how are you   #This comes as a suprise as we find out that the script doesn't get the j value. how do we solve this 
#We can solve this by using the curly braces around the 10 in $10 to look like this:  ${10}. the only problem being that some shells don't recognize it.

it simply does not understand $10 but it goes up to $9 # We can use 'shift' to solve this problem


*Using Shift 

Shift removes the first argument from a list so that the second argument gets stored in $1

Shift is useful in older shell versions that do not understand ${10} etc



#!/bin/bash
#Showing the use of shift

echo "The arguments provided are $*"   #This referrs to all arguments
echo "The value of \$1 is $1"
echo "The entire string is $*"
shift
echo "The new value of \$1 is $1"
echo "The entire string now is $*"

exit



#Running the script with inputs
vim shiftargument
shiftargument a b c 


#The solution after running the script will be
The arguments provided are a b c
The value of $1 is a
The entire string is a b c 
The new value of $1 is b    # We now see what the shit has done is basically shifted the whole sting right by one. more like shifting the indexing from 0 to 1
The entire string now is b c 




Using command substitution:
***************************

Command substitution allows using the result of a commans in the script

Useful to provide ultimate flexibility

Two allowed syntaxes:

`command` (Deprecated)   #it means it is not longer inuse in recent shells

$(command) (Preferred)

ls -l $(which passwd)  #This command will be showing you the exact path to the passwd file. #And the -l is providing you with the long listing information




#!/bin/bash
#This script cpoies /var/log contents and clears current contents of the file
#Usage: ./clearlogs


cp /var/log/messages /var/log/messages.$(date +%d-%m-%y)   #This simply renames the name of the file to an extension with date: /var/log/messages.26-09-20
cat /dev/null > /var/log/messages     # This prints the copy of the files to the messages file but in this case, nothing will be printed out 
echo log file copied and cleaned out 

exit 0




String Verification
********************

When working with arguments and input, it is useful to be able to verify availabliity and correct use of a string

use test -z to check if a string is empty 

    test -z $1 && exit 1    # The double and operator(&&) here means it's the rest of the line is only activated when the first command is successful

use [[ ... ]] to check for specific patterns 

    [[  $1=='[a-z]*'  ]]   echo $1 does not start with a letter #This is another way to do a string verification is by including a double equal sign (==)
    #following by the string we are trying to match here, it is inbetween a single quote
    # this pattern basically searches for where the arguments starts with any letter between a to z after which there is a logical or statement 
    #denoted by two pipes (||). this command will run only if the first command is not true 
    #also take note of the space between the test cases as this mskes the results entirely different or wrong 

    use this  ($1=='[a-z]*')     
    not this ($1=='[a-z]*')




Using Here Documents
********************

In a here document, I/O redirection is used to feed a command list into an interractive program or command, such as for instance ftp or cat

use it in scripts to replace echo for long texts that need to be displayed

use it in a script, such as an FTP client interface .


