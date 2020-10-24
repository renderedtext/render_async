module RenderAsync
  class Configuration
    attr_accessor :jquery, :turbolinks, :replace_container, :nonces

    def initialize
      @jquery = false
      @turbolinks = false
      @replace_container = true
      @nonces = false
    end
  end
end
