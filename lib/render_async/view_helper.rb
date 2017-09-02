require 'securerandom'

module RenderAsync
  module ViewHelper

    def render_async_cache_key(path)
      "render_async_#{path}"
    end

    def render_async_cache(path, html_options = {})
      cached_view = Rails.cache.read("views/#{render_async_cache_key(path)}")
      if cached_view.present?
        render "render_async/render_cached_view", :cached_view => cached_view
      else
        render_async(path, html_options)
      end
    end

    def render_async(path, html_options = {})
      container_name = "render_async_#{SecureRandom.hex(5)}#{Time.now.to_i}"

      render "render_async/render_async", :container_name => container_name,
                                          :path => path,
                                          :html_options => html_options
    end

  end
end
