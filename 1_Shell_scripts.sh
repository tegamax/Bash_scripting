#!/bin/bash


#Shell scripts: - What to know!
for the exercises i will be using the '##' symbol to indicate the unix prompt
## vim netconsole
## vim /etc/profile

to run a script we should use   ## ./myscript    where myscript is the name of the script
running a script without the ./ in the front will lead to unexpected results
in order to run the script we need to make sure that the script is executable 

## chmod +x myscript 
or you can use;
## chmod 755 myscript  
that is if the previous method did not work  



#Commands to start with
***************************************



vi hello-world

mv hello-world hello
cp hello test
chmod +x hello
./hello
test  #This didn't bring any results
which test #this will show you the current path 
echo $PATH #This will show the content of the path directory
mkdir bin
mv hello bin

./bin

always use the command #which myscript. To know if there is anything in path directory that exist with the name myscript and hence is ok to use that variable name 


#Creating  your first shell script.
**********************************************************************
Understanding the difference between Bash Internal and Bash external command
    An Internal command is part of the Bash shell 
        It does not have to be loaded from disk and therefore is faster 
        use the help to get a list of all the internal Commands

    An External command is a command that is loaded from an executable file on disk or a  different network location
        External commands are normally slower 




##type test  # This will tell you the type of the script i.e if this is a builtin or an external script
the shell always executes the internal command before the external command

Finding help about scripting components
##man bash
##help command_name
##help trap #This will show you all the trap commands available 
 
the Advanced Bash Scripting Guide on the website tldp.org also serves as an invaluable tool and it usually gets updated.

#Assignment 
create a script that copies the contnts of the log file  /var/log/messages to /var/log/messages.old and deletes the contents of the var/log/messages file


:Solution 1
***********

#!/bin/bash
#This is a script that copies /var/log contents and clears current contents of the file
#usage: ./clearlogs

cp /var/log/messages /var/log/messages.old
cat /dev/null > /var/log/messages
echo log file copied and cleaned up

exit 0
