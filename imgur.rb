require 'open-uri'
require 'net/http'
require 'json'
require 'base64'

class Imgur
  
  # add an API key to use for uploads
  def self.api_key=( api_key )
    @@api_key = api_key.to_s.chomp
  end
  
  def self.upload( options = {} )
    data = options[:data] ||
      options[:url] ||
      Base64.encode64(open(options[:filename]).read)
    post_data = { :key => @@api_key, :image => data }
    post_url = generate_url :method => :upload
    post_uri = URI.parse post_url
    response = JSON (Net::HTTP.post_form post_uri, post_data).body
    { :hash => response["upload"]["image"]["hash"],
      :delete_hash => response["upload"]["image"]["deletehash"],
      :filetype => response["upload"]["image"]["type"].gsub("image\/","") }
  end
  
  def self.upload_file( filename )
    upload :filename => filename
  end
  
  def self.get( hash, options = {} )
    open url_for hash, options
  end
  
  def self.stats
    json_get :method => :stats
  end
  
  def self.delete( delete_hash )
    json_get( :hash => delete_hash, :method => :delete )["delete"]["message"] == "Success"
  end
  
  def self.album( hash, options = {} )
    json_get :hash => hash, :method => :album
  end
  
  def self.url_for( hash, options = {} )
    sizes = {
      :small => :s,
      :large => :l }
    if options[:filetype] == :detect
      # fix this it's ugly
      options[:filetype] = json_get( :hash => hash, :method => :image )["image"]["image"]["type"].gsub("image\/","")
    end
    "http://i.imgur.com/#{hash}#{sizes[options[:size]]}.#{options[:filetype] || :png}"
  end
  
  def self.debug=( debug_setting )
    @debug = debug_setting
  end
  
  class << self
    alias_method :[], :url_for
  end
  
  private
  
  def debug( thing_to_debug, message = "" )
    puts message + thing_to_debug.to_s
    thing_to_debug
  end
  
  def self.json_get( options = {} )
    JSON open(generate_url options).read
  end
  
  def self.generate_url( options = {} )
    hash = options[:hash]
    method = options[:method]
    url = "http://api.imgur.com/2/"
    url += method.to_s
    url += "/" + hash.to_s if hash
    url += ".json"
    url
  end
  
end
