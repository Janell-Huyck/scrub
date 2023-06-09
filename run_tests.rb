#!/usr/bin/env ruby

# This script runs the scrub executable on all the test files in the
# test_files_for_end_to_end folder and compares the output to the expected
# output in the output.json file in each folder.
# It will print a message for each test that passes or fails.
#
# Run the following command from the root directory:
#
# ruby run_tests.rb
#
# You can also run the rspec tests by typing `rspec` from the root directory.
# The rspec tests are in the spec folder.
#

require 'json'
require_relative 'scrub_json.rb'

# Initialize an empty array to hold failed tests
failed_tests = []

# Loop through each folder in test_files_for_end_to_end
Dir.glob("#{File.expand_path(__dir__)}/test_files_for_end_to_end/*").each do |folder|
  next unless File.directory?(folder)

  # Set up file paths
  sensitive_fields_file = "#{File.expand_path(folder)}/sensitive_fields.txt"
  input_file = "#{File.expand_path(folder)}/input.json"
  output_file = "#{File.expand_path(folder)}/output.json"

  # Run the scrub executable
  cmd = "./scrub #{sensitive_fields_file} #{input_file}"
  puts "Running command: #{cmd}"
  system(cmd)

  # Load expected output from output_file
  expected_output = JSON.parse(File.read(output_file))

  # Load actual output from scrub executable
  actual_output = JSON.parse(`#{cmd}`)

  # Compare actual and expected outputs
  if expected_output != actual_output
    failed_tests << folder
  end
end

# Print success message or list of failed tests
if failed_tests.empty?
  puts "All tests passed!"
else
  puts "The following tests failed:"
  failed_tests.each do |folder|
    puts folder
  end
end
