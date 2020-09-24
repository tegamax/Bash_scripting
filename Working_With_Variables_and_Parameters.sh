
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




   