
Design Considerations
*********************


Write readable!

    Include white lines
    Include comments
    Be compact only if you need 

Don\'t write for yourself , but write for the person who works with the script

develop for speed   #Using internal command as opposed to the external commands

Use exit to identify specific errors
#Use documentation to define what exit or error codes that the script throws up


Common Analyzing tools
*********************

Use bash highlighting available in editors

in vim use :set list to show hidden characters  use set nolist to reverse

In the script code, insert echo or read at critical points   # it allows you to check for critical break point
#If there is read on a line by itself it will halt the script demanding for an input 

Use bash -v  to show verbose output (Including error messages)

Use bash -n  to check for syntax errors 

Use bash -x to show xtrace information 

Use the DEBUG trap to show debugging information for everything between setting it on and off  #This is equavalent to using the bash -x
#The only difference it that while bash -x does it for the whole script, the DEBUG trap command does it for a section of the script
#Used to identify specific lines in a script that has errors, you can get a drilldown to see what those lnes are doing

#DEBUG trap Example

#!/bin/bash

function erroneous
{
            echo the error is $error
}

trap DEBUG

echo this line is OK
erroneous

trap -DEBUG

echo this line is also good

#The debug command is used if the script is very long to halp look at one particular section of the script 

'''
#Tested Network
***************

#!/bin/bash
#
# Define the network that is tested

echo On what network do you want to test? \(please a 4 byte number\)
echo Press enter if you want to scan the whole network
read NETWORK
[ -z $NETWORK ] && NETWORK=`ip a s | grep eth0 | head -n 3 | tail -n 1 | awk '{print $2 }'` && \
        NETWORK=${NETWORK%/}
NETWORK=${NETWORK%.*}

#Remove old uplist file existing
rm /tmp/uplist

#run the program 
for (( NODE=1; NODE<20; NODE++ )); do
        if ping -c 1 $NETWORK.$NODE 
        then
        echo $NETWORK.$NODE >> /tmp/uplist 
done

echo press enter to display the list
read

cat /tmp/uplist
exit 0
'''





ps aux
kill pid#
double plus ++ #this includes the subshell



Exercise 7
***********
Find the error in the script:

#!/bin/bash
#
# Define the network that is tested

echo On what network do you want to test? \(please a 4 byte number\)
echo Press enter if you want to scan the whole network
read NETWORK
[ -z $NETWORK ] && NETWORK=`ip a s | grep eth0 | head -n 3 | tail -n 1 | awk '{print $2 }'` && \
        NETWORK=${NETWORK%/}
NETWORK=${NETWORK%.*}

#Remove old uplist file existing
rm /tmp/uplist

#run the program 
for (( NODE=1; NODE<20; NODE++ )); do
        if ping -c 1 $NETWORK.$NODE 
        then
        echo $NETWORK.$NODE >> /tmp/uplist 
done

echo press enter to display the list
read

cat /tmp/uplist
exit 0



Solution
********

1, Run the script. ensure that it is executable by using the command# chmod -x <SCRIPT_NAME>
2, go into the script. vim <SCRIPT_NAME>. type in <:set list> . To show any hidden characters in the script.
3, use bash -x to troubleshoot to see what is really going on in the background 
we now notice that the ping command is pinging a snippet of the IP address and not the whole IP address.
'''
ping: IDN encoding failed: Output would be too large or too small
(( NODE++ ))
((NODE<20  ))
echo press enter to display the list
press enter to display the list
'''
4, next we start looking at each line to know what the output of tthe commands will be and trying to verify it.
'''
Looking at the ip a s command:
ip a s #
ip a s | grep eth0 | head -n 3 | tail -n 1 | awk '{print $2 }' #it returns nothing when ran
drilling down to ip a s #we get a result using that command.

the next is to check the grep command. the grep command comes up wrong. it is actually called eno16777736 hence the script cannot be portable. 
We can choose to hardcode this part using the name of the network card or try to pull the name of the network card from the first command using the sed command.

#This will work now
ip a s | grep eno16777736 | head -n 3 | tail -n 1 | awk '{print $2 }'

there is another error here

NETWORK=${NETWORK%/*} theree should be a star symbol (*) after the backslash symbol 

this shows a small representation of how to troubleshoot in Bash.
'''

