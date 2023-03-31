# scrub



Scrub is a Ruby command-line executable that accepts two arguments
  1) a file ("sensitive_fields.txt") containing sensitive fields
  2) a file ("input.json") containing a valid JSON of data that needs to be "scrubbed"
  
When called from the command line with those two arguments, it prints out to the terminal the input JSON, with all "sensitive" fields "scrubbed".  In this case, "scrubbing" means turning all alphanumeric characters into asterisks ("*****").

## How to run the code:

 - You will need to have Ruby installed on your computer.  This executable was written in Ruby 3.0.0, but should work with any version of Ruby 2.7 or higher.

 - You will need to download this Github repository.  
Then, in your terminal, navigate to inside the "scrub" directory.
Enter the following command: 
`./scrub sensitive_fields.txt input.json`

 - "sensitive_fields.txt" is a text-based list of fields that need to be scrubbed out.  Each line in the file should contain only one field name. (name, email, etc)
 - "input.json" is a JSON file of text that needs to be scrubbed.
