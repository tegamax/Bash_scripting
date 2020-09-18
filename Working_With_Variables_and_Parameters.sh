
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











   