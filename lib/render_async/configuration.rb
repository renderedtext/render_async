module RenderAsync
  class Configuration
    attr_accessor :jquery, :turbolinks, :turbo, :replace_container, :nonces

    def initialize
      @jquery = false
      @turbolinks = false
      @turbo = false
      @replace_container = true
      @nonces = false
    end
  end
end
