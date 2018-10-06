require "render_async/version"
require "render_async/view_helper"
require "render_async/engine" if defined? Rails
require "render_async/configuration"

ActionView::Base.send :include, RenderAsync::ViewHelper if defined? ActionView::Base

module RenderAsync
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= RenderAsync::Configuration.new
  end

  def self.reset
    @configuration = RenderAsync::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
