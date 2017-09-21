require 'securerandom'

module RenderAsync
  module ViewHelper

    def render_async_cache_key(path)
      "render_async_#{path}"
    end

    def render_async_cache(path, html_options = {})
      cached_view = Rails.cache.read("views/#{render_async_cache_key(path)}")
      if cached_view.present?
        render :html => cached_view.html_safe
      else
        render_async(path, html_options)
      end
    end

    def render_async(path, html_options = {}, &placeholder)
      container_id = "render_async_#{SecureRandom.hex(5)}#{Time.now.to_i}"
      placeholder = capture(&placeholder) if block_given?

      render 'render_async/render_async', container_id: container_id,
                                          path: path,
                                          html_options: html_options,
                                          placeholder: placeholder
    end

  end
end
