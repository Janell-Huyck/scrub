class ScrubJson
  def initialize(sensitive_fields, input_json)
    @sensitive_fields = sensitive_fields
    @input_json = input_json
  end

  def scrub
    @input_json.each do |key, value|
      @input_json[key] = scrub_value(value)
    end

  end

  def scrub_value(value)
    if value.is_a?(Hash)
      scrub_hash(value)
    elsif value.is_a?(Array)
      scrub_array(value)
    else
      scrub_string(value)
    end
  end

  def scrub_hash(hash)
    hash.each do |key, value|
      hash[key] = scrub_value(value)
    end
  end

  def scrub_array(array)
    array.map do |value|
      scrub_value(value)
    end
  end

  def scrub_string(string)
    if @sensitive_fields.include?(string)
      '********'
    else
      string
    end
  end

  def declare
    puts "I am a scrubber.  I have functions that aren't checked yet."
    puts "Sensitive fields: #{@sensitive_fields}"
    puts "Input JSON: #{@input_json}"
  end

end