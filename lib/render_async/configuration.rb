module RenderAsync
  class Configuration
    attr_accessor :jquery, :turbolinks

    def initialize
      @jquery = false
      @turbolinks = false
    end
  end
end
