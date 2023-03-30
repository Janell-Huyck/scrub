

require 'json'
require_relative '../lib/scrub'

sensitive_fields = File.open(ARGV[0]).readlines.map(&:strip)
input_json = JSON.parse(File.open(ARGV[1]).read)

scrubber = Scrub.new(sensitive_fields, input_json)

scrubber.declare
