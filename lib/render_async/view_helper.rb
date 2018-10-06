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
      html_element_name = options.delete(:html_element_name) || 'div'
      container_id = options.delete(:container_id) || generate_container_id
      container_class = options.delete(:container_class)
      event_name = options.delete(:event_name)
      placeholder = capture(&placeholder) if block_given?
      method = options.delete(:method) || 'GET'
      data = options.delete(:data)
      headers = options.delete(:headers) || {}
      error_message = options.delete(:error_message)
      error_event_name = options.delete(:error_event_name)

      render 'render_async/render_async', html_element_name: html_element_name,
                                          container_id: container_id,
                                          container_class: container_class,
                                          path: path,
                                          html_options: options,
                                          event_name: event_name,
                                          placeholder: placeholder,
                                          method: method,
                                          data: data,
                                          headers: headers,
                                          error_message: error_message,
                                          error_event_name: error_event_name
    end

    private

    def generate_container_id
      "render_async_#{SecureRandom.hex(5)}#{Time.now.to_i}"
    end
  end
end
