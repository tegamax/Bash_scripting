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
**********************************************************************



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

always use the command #which myscript. to know if there is anything in path directory that exist with the name myscript and hence is ok to use that variable name 


#Creating  your first shell script.
**********************************************************************
Understanding the difference between Bash Internal and Bash external command
    An Internal command is part of the Bash shell 
        It does not have to be loaded from disk and therefore is faster 
        use the help to get a list of all the internal Commands

    An External command is a command that is loaded from an executable file on disk or a  different network location
        External commands are normally slower 

 