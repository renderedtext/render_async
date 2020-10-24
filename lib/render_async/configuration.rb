module RenderAsync
  class Configuration
    attr_accessor :jquery, :turbolinks, :replace_container

    def initialize
      @jquery = false
      @turbolinks = false
      @replace_container = true
    end
  end
end
