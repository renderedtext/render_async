require 'securerandom'

module RenderAsync
  module ViewHelper

    def render_async(path, html_options = {}, &block)
      container_id = "render_async_#{SecureRandom.hex(5)}#{Time.now.to_i}"

      render 'render_async/render_async', container_id: container_id,
                                          path: path,
                                          html_options: html_options,
                                          block: capture(&block)
    end

  end
end
