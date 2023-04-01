# This is how I approached this problem:

It seemed to me that the main thrusts of the assessment were:
1) managing command line executables
2) correctly dealing with datatypes
3) iteration and recursion within the JSON hash
4) testing

## Managing command line executables
Before this assessment, I had never written a Ruby command line executable.  A quick search turned up this excellent 
tutorial video: https://www.youtube.com/watch?v=VDdgFCskcnQ This video was a walkthrough on the basics of how to create
a command that echoed back what someone's favorite color was when it was given as a string argument.  I used this 
tutorial as a starting point for my own command line executable.

## Correctly dealing with datatypes and the JSON hash

The requirements for each datatype were clearly laid out in the assessment instructions.
This was a perfect set-up for me to use TDD.  I wrote a test for each datatype, and then wrote the code to make the test pass.

## Iteration and recursion within the JSON hash

There was smooth sailing until I got to the nested items in hashes.  I had been drilling recursively into
each datatype, and only scrubbing values that were directly connected to the sensitive keys.  I realized that
as I was drilling into a hash, if a key was sensitive, then I needed to scrub all of the values in that hash.

I created a few new methods to handle this situation, where I was still drilling in recursively, but omitting
the check for whether a key was sensitive.

## Testing
I used Rspec to create unit tests for each datatype.  Rspec is not designed to be able to handle
tests for executables.  To test the executable with the test files provided by ActBlue, I wrote another
script that would run as an executable and compare the output to the expected output for the files in each
of the ten test folders provided.  

### To run the tests:

Running the rspec unit tests, from the root directory sinply run:
```
rspec
```

To run the executable tests from the root directory:
First, you must disable the check for the correct number of arguments in the scrub executable.
To do this, comment out the following lines in the scrub executable:
```
 if ARGV.length != 2
   puts
   puts "*** ERROR: Incorrect number of arguments ***"
   puts "You passed #{ARGV.length} arguments, but this script requires exactly 2 arguments."
   puts "Example: ./script.rb sensitive_fields.txt input.json"
   puts "********"
   exit 1
 end
```
Then, run the executable tests from the command line:
```
ruby run_tests.rb
```

## Final thoughts
I enjoyed making this executable.  It was a good exercise in learning how to write a command line executable
and good practice in using TDD to write code.  Thanks for the opportunity to work on this assessment!



