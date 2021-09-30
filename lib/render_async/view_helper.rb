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

      render 'render_async/render_async', **container_element_options(options),
                                          path: path,
                                          html_options: html_options(options),
                                          event_name: event_name,
                                          placeholder: placeholder,
                                          **request_options(options),
                                          **error_handling_options(options),
                                          **retry_options(options),
                                          **polling_options(options),
                                          **content_for_options(options)
    end

    private

    def container_element_options(options)
      { html_element_name: options[:html_element_name] || 'div',
        container_id: options[:container_id] || generate_container_id,
        container_class: options[:container_class],
        replace_container: replace_container(options) }
    end

    def html_options(options)
      set_options = options.delete(:html_options) || {}

      set_options[:nonce] = configuration.nonces if set_options[:nonce].nil?

      set_options
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

    def retry_options(options)
      {
        retry_count: options.delete(:retry_count) || 0,
        retry_count_header: options.delete(:retry_count_header),
        retry_delay: options.delete(:retry_delay)
      }
    end

    def polling_options(options)
      { interval: options[:interval],
        toggle: options[:toggle] }
    end

    def content_for_options(options)
      {
        content_for_name: options[:content_for_name] || :render_async
      }
    end

    def generate_container_id
      "render_async_#{SecureRandom.hex(5)}#{Time.now.to_i}"
    end

    def replace_container(options)
      return options[:replace_container] unless options[:replace_container].nil?

      configuration.replace_container
    end

    def configuration
      RenderAsync.configuration
    end
  end
end
