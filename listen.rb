require 'listen'
require_relative 'config'

config = LocalConfig.new

Listen.to(config.dir) do |mod, add, rm|
  unless add.nil?
    puts add
  end
end
