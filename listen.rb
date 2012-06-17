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
  Guard::Notifier::NotifySend::notify 'notify', "Autoupload", "Saca screenshots!", nil
end

Listen.to("#{File.dirname __FILE__}/#{config.dir}") do |mod, add, rm|
  unless (add = add.first).nil?
    Guard::Notifier::NotifySend::notify 'notify', "Autoupload", "Subiendo imagen...", nil
    puts add
    response = Imgur.upload_file(add)
    sleep 1
    img_url = Imgur.url_for(response[:hash], response)
    puts img_url
    system("echo '#{img_url}' | xclip -selection clipboard")
    Guard::Notifier::NotifySend::notify 'notify', "Autoupload", "URL copiada al portapapeles", nil
  end
end
