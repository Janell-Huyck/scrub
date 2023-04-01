# scrub

Scrub is a Ruby command-line executable that accepts two arguments
  1) a file ("sensitive_fields.txt") containing sensitive fields, one per line.
  2) a file ("input.json") containing a valid JSON of data that needs to be "scrubbed"
  
When called from the command line with those two arguments, it prints out to the terminal the input JSON, with all 
"sensitive" fields "scrubbed".  In this case, "scrubbing" means turning all alphanumeric characters into 
asterisks ("*****").

## How to run the code:

 - You will need to have Ruby installed on your computer.  This executable was written in Ruby 3.0.0.
 - You will need to download [this Github repository](https://github.com/Janell-Huyck/scrub).  
   (If you need assistance, please check out [this helpful article](https://blog.hubspot.com/website/download-from-github))
 - Open your terminal and navigate to inside the "scrub" directory (the repository you just downloaded).
 - Enter the following command:
   `./scrub sensitive_fields.txt input.json`

   - "sensitive_fields.txt" is a text-based list of fields that need to be scrubbed out.  Each line in the file should 
contain only one field name. (name, email, etc)  Do not put quotes around the field names.
   - "input.json" is a JSON file of text that needs to be scrubbed.
 - If you get an error message saying that you do not have permission to run the file, run the following command in 
your terminal: `chmod +x scrub` and try again.
 - If you want to see the output in a file instead of the terminal, you can run the following command:
   `./scrub sensitive_fields.txt input.json > output.json`

## How to run the tests:
    
 - You will need to have Rspec installed on your computer as well as Ruby.
 - Navigate in your terminal to the "scrub" directory (same place as where you were running the executable).
 - Run the following command: `rspec`

## How to run the executable tests:

- You will need to have Ruby installed on your computer.
- Navigate in your terminal to the "scrub" directory (same place as where you were running the executable).
- Comment out the following lines in the "scrub" executable:
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
- Run the following command: `ruby run_tests.rb`
   
