# This is how I approached this problem:

It seemed to me that the main thrusts of the assessment were:
1) managing command line executables
2) correctly dealing with datatypes
3) iteration and recursion within the JSON hash
4) testing

## Managing command line executables
Before this assessment, I had never written a Ruby command line executable.  A quick search turned up this excellent tutorial video:
https://www.youtube.com/watch?v=VDdgFCskcnQ

This video was a walkthrough on the basics of how to create a command that echoed back what someone's favorite color was when it was given as a string argument.

It taught me:
 - Using the require_relative command in the executable file ("scrub") to reference the code written in the main code file ("scrub_json.rb").
 - Using the ARGV array to access the arguments passed to the command
 - Setting up permissions so that anyone can execute the file
 - Using the shebang line to tell the computer what interpreter to use to run the file

I used this tutorial as a starting point for my own command line executable.

## Correctly dealing with datatypes and the JSON hash

The requirements for each datatype were clearly laid out in the assessment instructions.
This was a perfect set-up for me to use TDD.  I wrote a test for each datatype, and then wrote the code to make the test pass.
Github copilot assisted in writing the classes and tests, but significant modifications were made to
the code to make it work.

## Iteration and recursion within the JSON hash

There was smooth sailing until I got to the nested items in hashes.  I had been drilling recursively into
each datatype, and only scrubbing values that were directly connected to the sensitive keys.  I realized that
as I was drilling into a hash, if a key was sensitive, then I needed to scrub all of the values in that hash.

I created a few new methods to handle this situation, where I was still drilling in recursively, but omitting
the check for whether a key was sensitive.

## Testing
I was using Rspec to create unit tests for each datatype.  Rspec is not designed to be able to handle
tests for executables.  I was unable to find a way to test the executable using Rspec.  I ended up
testing the executable by running it in the command line and checking the output.

I wanted to make things a little easier on myself, so I created an optional argument for the executable
that allows the user to specify an expected output file.  Then, running with three arguments instead of two, 
the executable will compare the output to the expected output and print a message of success or failure.

Because this was not part of the specifications, I commented this out, but left it in the code for discussion
purposes with reviewers.

## Final thoughts
I enjoyed making this executable.  It was a good exercise in learning how to write a command line executable,
and good practice in using TDD to write code.  I would like to learn more about how to test executables.



