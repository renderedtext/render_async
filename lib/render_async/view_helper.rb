require 'securerandom'

module RenderAsync
  module ViewHelper

    def render_async_cache_key(path)
      "render_async_#{path}"
    end

    def render_async_cache(path, options = {}, &placeholder)
      cached_view = Rails.cache.read("views/#{render_async_cache_key(path)}")

      if cached_view.present?
        render :html => cached_view.html_safe
      else
        render_async(path, options, &placeholder)
      end
    end

    def render_async(path, options = {}, &placeholder)
      container_id = "render_async_#{SecureRandom.hex(5)}#{Time.now.to_i}"
      event_name = options.delete(:event_name)
      placeholder = capture(&placeholder) if block_given?

      render 'render_async/render_async', container_id: container_id,
                                          path: path,
                                          html_options: options,
                                          event_name: event_name,
                                          placeholder: placeholder
    end

  end
end
