GEM_ROOT = File.expand_path("../../", __FILE__)
$:.unshift File.join(GEM_ROOT, "lib")

if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear!
else
  require 'simplecov'
end

require 'rspec'
require 'factory_girl'
require 'kahuna'

Dir[File.join(GEM_ROOT, "spec", "support", "**/*.rb")].each { |f| require f }
Dir[File.join(GEM_ROOT, "spec/factories/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
end
