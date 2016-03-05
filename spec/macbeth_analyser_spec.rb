require 'spec_helper'

describe 'macbeth_analyser.rb' do
  specify { expect { require_relative '../macbeth_analyser.rb' }.to output("hello\n").to_stdout }
end
