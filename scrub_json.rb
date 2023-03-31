# This class will scrub a json object based on a list of sensitive fields.
# It will scrub all values in the json object that are sensitive fields.
# It will also scrub all values in any nested hashes or arrays that are
# sensitive fields.

class ScrubJson
  def initialize(sensitive_fields, input_json)
    @sensitive_fields = sensitive_fields
    @input_json = input_json
  end

  # This function will scrub the @input_json defined upon initialization.
  def scrub
    @input_json.each do |key, value|
      @input_json[key] = scrub_value(key,value)
    end
  end


  private

  # This function will conditionally scrub a value based on its type
  def scrub_value(key, value)
    return nil if value.nil?
    key = key.to_s

    if value.is_a?(Hash)
      scrub_hash(key, value)
    elsif value.is_a?(Array)
      scrub_array(key, value)
    else
      scrub_string(key, value)
    end
  end

  # This function will conditionally scrub a hash based on the key.
  # If the key is a sensitive field, it will scrub all values in the hash
  # otherwise it will scrub the values in the hash that are sensitive fields.
  def scrub_hash(key, hash)
    key = key.to_s
    return scrub_everything_in_hash(hash) if @sensitive_fields.include?(key)

    hash.each do |k, v|
      hash[k] = scrub_value(k,v)
    end
  end

  # This is a recursive function that will scrub all values in a hash
  # and all values in any nested hashes or arrays if the key for the hash
  # is a sensitive field.  It is only called if the key for the hash is
  # a sensitive field.
  def scrub_everything_in_hash(hash)
    hash.each do |k, v|
      if v.is_a?(Hash)
        hash[k] = scrub_everything_in_hash(v)
      elsif v.is_a?(Array)
        hash[k] = scrub_everything_in_array(v)
      else
        hash[k] = scrub_this_value(v)
      end
    end
  end

  # This is a recursive function that will scrub all values in an array
  # and all values in any nested hashes or arrays if the key for the array.
  # It is only called if the key for the array is a sensitive field.
  #
  def scrub_everything_in_array(array)
    array.map do |elem|
      if elem.is_a?(Hash)
        scrub_everything_in_hash(elem)
      elsif elem.is_a?(Array)
        scrub_everything_in_array(elem)
      else
        scrub_this_value(elem)
      end
    end
  end


  # This function will scrub a single value.
  # It does not check if the key is a sensitive field.
  def scrub_this_value(value)
    return nil if value.nil?
    return '-' if [true, false].include? value

    unless value.is_a?(String)
      value=value.to_s
    end

    value.gsub(/[a-zA-Z0-9]/, '*')
  end

  # This function will conditionally scrub all values in an array.
  def scrub_array(key, array)
    array.map do |value|
      scrub_value(key, value)
    end
  end

  # This function will conditionally scrub a string.
  def scrub_string(key, value)
    return nil if value.nil?

    key = key.to_s
    if @sensitive_fields.include?(key)
      return '-' if [true, false].include? value

      unless value.is_a?(String)
        value=value.to_s
      end

      value.gsub(/[a-zA-Z0-9]/, '*')
    else
      value
    end
  end
end