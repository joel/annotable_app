require 'fabrication'

Fabrication.configure do |config|
  config.fabricator_path = 'spec/fabricators'
  config.path_prefix = Annotable::Engine.root
end
