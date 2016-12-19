require "render_async/version"
require "render_async/view_helper"
require "render_async/engine" if defined? Rails

ActionView::Base.send :include, RenderAsync::ViewHelper if defined? ActionView::Base
