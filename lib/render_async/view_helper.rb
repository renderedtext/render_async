require 'securerandom'

module RenderAsync
  module ViewHelper

    def render_async(path)
      cached_view = Rails.cache.read("views/#{path}_cached")
      render cached_view and return if cached_view.present?
      
      container_name = "render_async_#{SecureRandom.hex(5)}#{Time.now.to_i}"

      render "render_async/render_async", :container_name => container_name,
                                          :path => path
    end

  end
end
