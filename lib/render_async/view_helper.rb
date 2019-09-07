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
      placeholder = capture(&placeholder) if block_given?

      event_name = options[:event_name]
      html_options = options[:html_options] || {}
      lazy_load = options[:lazy_load] || false

      render 'render_async/render_async', path: path,
                                          html_options: html_options,
                                          event_name: event_name,
                                          placeholder: placeholder,
                                          lazy_load: lazy_load,
                                          **retry_options(options),
                                          **container_element_options(options),
                                          **request_options(options),
                                          **error_handling_options(options),
                                          **polling_options(options)
    end

    private
    def retry_options(options)
      {
        retry_count: options[:retry_count],
        delay_on_error: options[:retry_delay_on_error],
        retry_event_name: options[:retry_event]
      }
    end

    def container_element_options(options)
      {
        html_element_name: options[:html_element_name] || 'div'.freeze,
        container_id: options[:container_id] || generate_container_id,
        container_class: options[:container_class]
      }
    end

    def request_options(options)
      {
        request_method: options[:method] || 'GET'.freeze,
        request_data: options[:data],
        headers: options[:headers] || {}
      }
    end

    def error_handling_options(options)
      {
        error_message: options[:error_message],
        error_event_name: options[:error_event_name]
      }
    end

    def polling_options(options)
      {
        interval: options[:interval]
      }
    end

    private

    def generate_container_id
      "render_async_#{SecureRandom.hex(5)}#{Time.now.to_i}"
    end
  end
end