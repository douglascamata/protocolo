require 'spec_helper'

describe Usuario do
  it{ should_not have_valid(:papel).when nil}      
end
