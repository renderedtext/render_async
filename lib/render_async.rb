require "render_async/version"
require "render_async/view_helper"

ActionView::Base.send :include, RenderAsync::ViewHelper if defined? ActionView::Base
