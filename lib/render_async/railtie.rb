require 'render_async/view_helper'

module RenderAsync
  class Railtie < Rails::Railtie
    initializer "render_async.view_helper" do
      ActionView::Base.send :include, ViewHelper
    end
  end
end

require 'render_async/rails/engine'
