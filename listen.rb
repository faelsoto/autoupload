require 'listen'
require_relative 'config'
require_relative 'imgur'

config = LocalConfig.new

Listen.to(config.dir) do |mod, add, rm|
  unless add.nil?
    puts add
  end
end
