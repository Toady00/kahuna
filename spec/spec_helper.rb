require 'simplecov'

GEM_ROOT = File.expand_path("../../", __FILE__)
$:.unshift File.join(GEM_ROOT, "lib")

require 'rspec'
require 'factory_girl'
require 'kahuna'

Dir[File.join(GEM_ROOT, "spec", "support", "**/*.rb")].each { |f| require f }
Dir[File.join(GEM_ROOT, "spec/factories/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
end
