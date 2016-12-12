require "render_async/version"

ActiveSupport.on_load(:action_view) { include RenderAsync::ViewHelper }
