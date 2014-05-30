require 'bundler' ; Bundler.require :development, :test
require 'sassy-maps'
require 'navigator'
require 'minitest/autorun'

class SassyMapsTest < Minitest::Test

  include Navigator::Assertions


end
