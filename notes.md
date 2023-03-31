# This is how I approached this problem:

It seemed to me that the two main thrusts of the assessment were:
1) managing command line executables
2) correctly dealing with datatypes and the JSON hash

## Managing command line executables
Before this assessment, I had never written a Ruby command line executable.  A quick search turned up this excellent tutorial video:
https://www.youtube.com/watch?v=VDdgFCskcnQ

This video was a walkthrough on the basics of how to create a command that echoed back what someone's favorite color was when it was given as a string argument.

It taught me:
 - Using lib and bin folders to organize code   
 - Using the require_relative command in the bin file to reference the code written in the lib file.
 - Using the ARGV array to access the arguments passed to the command
 - Setting up permissions so that anyone can execute the file
 - Using the shebang line to tell the computer what interpreter to use to run the file

I used this tutorial as a starting point for my own command line executable.

## Correctly dealing with datatypes and the JSON hash

