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
      event_name = options.delete(:event_name)
      placeholder = capture(&placeholder) if block_given?
      retry_count = options.delete(:retry_count) || 0
      html_options = options.delete(:html_options) || {}

      render 'render_async/render_async', **container_element_options(options),
                                          path: path,
                                          html_options: html_options,
                                          event_name: event_name,
                                          placeholder: placeholder,
                                          **request_options(options),
                                          **error_handling_options(options),
                                          retry_count: retry_count,
                                          **polling_options(options)
    end

    private

    def container_element_options(options)
      { html_element_name: options[:html_element_name] || 'div',
        container_id: options[:container_id] || generate_container_id,
        container_class: options[:container_class] }
    end

    def request_options(options)
      { method: options[:method] || 'GET',
        data: options[:data],
        headers: options[:headers] || {} }
    end

    def error_handling_options(options)
      { error_message: options[:error_message],
        error_event_name: options[:error_event_name] }
    end

    def polling_options(options)
      { interval: options[:interval],
        toggle: options[:toggle] }
    end

    private

    def generate_container_id
      "render_async_#{SecureRandom.hex(5)}#{Time.now.to_i}"
    end
  end
end
