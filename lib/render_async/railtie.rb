require 'render_async/view_helpers'

module RenderAsync
  class Railtie < Rails::Railtie
    initializer "render_async.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end

require 'render_async/rails/engine'
