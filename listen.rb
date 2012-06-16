require 'listen'
require_relative 'config'
require_relative 'imgur'

config = LocalConfig.new
Imgur.api_key = config.api_key


Listen.to(config.dir) do |mod, add, rm|
  unless add.nil?
    puts add
    response = Imgur.upload_file(add.first)
    img_url = Imgur.url_for(response[:hash], response)
    puts img_url
    system("echo \"#{img_url}\" | xclip -selection clipboard")
  end
end
