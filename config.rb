class LocalConfig
  attr_accessor :api_key, :dir

  def initialize
    @api_key = ""
    @dir = "uploads"
  end
end
