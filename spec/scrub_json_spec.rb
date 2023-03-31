require './scrub_json.rb'

# Because of the scope of the project and because I'm the only one
# who is using these tests, I felt comfortable defining the
# "sensitive fields" within this helper function.  If this were a
# larger project, I would probably define the sensitive fields in
# the tests themselves.  That would avoid confusion for anyone else who
# might be reading the tests. It would also make it easier to
# change the sensitive fields for a specific test.

def correctly_scrubs_input (input_json, expected_output)
  sensitive_fields = %w[password alternate-password]
  scrubber = ScrubJson.new(sensitive_fields, input_json)
  output = scrubber.instance_variable_get(:@input_json)
  scrubber.scrub
  expect(output).to eq(expected_output)
end

describe ScrubJson do

  # Not using helper function because I want to test the
  # behavior when the sensitive fields are empty.
  it 'scrubs nothing when the sensitive fields are empty' do
    sensitive_fields = []
    input_json = { 'password':'averylongpassword' }
    expected_output = { 'password':'averylongpassword' }

    scrubber = ScrubJson.new(sensitive_fields, input_json)
    scrubber.scrub
    output = scrubber.instance_variable_get(:@input_json)
    expect(output).to eq(expected_output)
  end

  it 'does not change a nil' do
    input_json = { 'password':nil }
    expected_output = { 'password':nil }
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'scrubs a string' do
    input_json = { 'password':'averylongpassword' }
    expected_output = { 'password':'*****************' }
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'only scrubs alphanumeric characters' do
    input_json = { 'password':'averylongpassword!@#$%^&*().' }
    expected_output = { 'password':'*****************!@#$%^&*().' }
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'only scrubs the sensitive fields' do
    input_json = { 'password':'averylongpassword', eyes:'brown' }
    expected_output = { 'password':'*****************', 'eyes':'brown' }
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'scrubs a number' do
    input_json = { 'password':30 }
    expected_output = { 'password':'**' }
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'scrubs a boolean' do
    input_json = { 'password':true, 'alternate-password':false }
    expected_output = { 'password':'-', 'alternate-password':'-' }
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'scrubs an array' do
    input_json = { 'password':['averylongpassword', 'pwd'] }
    expected_output = { 'password':['*****************', '***'] }
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'scrubs a hash' do
    input_json = { 'password':{'eye-color':'brown'} }
    expected_output = { 'password':{'eye-color':'*****'} }
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'scrubs a nested hash' do
    input_json = {'name':'Jordan', 'email':{'address': 'joe@google.com', 'password':'round'}}
    expected_output = {'name':'Jordan', 'email':{'address': 'joe@google.com', 'password':'*****'}}
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'scrubs a nested array' do
    input_json = {'password': {'eye-color': ['brown', 'blue']}}
    expected_output = {'password': {'eye-color': ['*****', '****']}}
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'scrubs a nested array with a hash and a nested array' do
    input_json = {'email':['joe@google.com', {'password':'round', 'server': 'Google', 'alternate-password':['averylongpassword', 'pwd']}]}
    expected_output = {'email':['joe@google.com', {'password':'*****', 'server': 'Google', 'alternate-password':['*****************', '***']}]}
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'scrubs a nested hash with a hash' do
    input_json = {'password' => {'eye-color' => {'favorite' => {'color' => 'brown'}}}}
    expected_output = {'password' => {'eye-color' => {'favorite' => {'color' => '*****'}}}}
    correctly_scrubs_input(input_json, expected_output)
  end

  it 'scrubs an object with all of the following: string, number, boolean, array, hash, and nil' do
    input_json = {'password':['averylong@password.com',30, true, nil], 'alternate-password': {'favorite-number':nil}, 'eyes': {'color': 'brown', 'shape': 'round'}}
    expected_output = {'password':['*********@********.***', '**', '-', nil], 'alternate-password': {'favorite-number':nil}, 'eyes': {'color': 'brown', 'shape': 'round'}}
    correctly_scrubs_input(input_json, expected_output)
  end
end