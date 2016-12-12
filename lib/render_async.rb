require "render_async/version"
require "render_async/view_helper"

ActiveSupport.on_load(:action_view) { include RenderAsync::ViewHelper }
