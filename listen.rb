require 'listen'
require 'guard'
require_relative 'config'
require_relative 'imgur'

config = LocalConfig.new
Imgur.api_key = config.api_key

if config.api_key.empty?
  Guard::Notifier::NotifySend::notify "failure", "Autoupload", "Error: Te falta agregar la API key.", nil
  abort 
else
  Guard::Notifier::NotifySend::notify nil, "Autoupload", "Saca screenshots!", nil
end

Listen.to("#{File.dirname __FILE__}/#{config.dir}") do |mod, add, rm|
  unless add.nil?
    puts add
    response = Imgur.upload_file(add.first)
    img_url = Imgur.url_for(response[:hash], response)
    puts img_url
    system("echo \"#{img_url}\" | xclip -selection clipboard")
    Guard::Notifier::NotifySend::notify nil, "Autoupload", "URL copiada al portapapeles", nil
  end
end
