require "spec_helper"

describe RenderAsync::ViewHelper do
  let(:helper) { Class.new { extend RenderAsync::ViewHelper } }

  describe "#render_async_cache_key" do
    it "returns cache key" do
      expect(helper.render_async_cache_key("users")).to eq("render_async_users")
    end
  end

  describe "#render_async_cache" do
    let(:cached_view) { double("CachedView",
                               :html_safe => "<h1>I'm cache</h1>",
                               :present? => true) }
    before do
      stub_const("Rails", double("Rails"))
    end

    context "cache is present" do
      before do
        allow(Rails).to receive_message_chain(:cache, :read).and_return(cached_view)
      end

      it "renders cached HTML" do
        expect(helper).to receive(:render).with(
          :html => "<h1>I'm cache</h1>"
        )

        helper.render_async_cache("users")
      end
    end

    context "cache is not present" do
      let(:empty_cache) { double("EmtpyCache", :present? => false) }

      before do
        allow(Rails).to receive_message_chain(:cache, :read).and_return(empty_cache)
      end

      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            :container_id => /render_async_/,
            :path => "users",
            :html_options => {},
            :event_name => nil,
            :placeholder => nil
          }
        )

        helper.render_async_cache("users")
      end
    end
  end

  describe "#render_async" do
    before do
      allow(helper).to receive(:render)
    end

    context "called with just path" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            :container_id => /render_async_/,
            :path => "users",
            :html_options => {},
            :event_name => nil,
            :placeholder => nil
          }
        )

        helper.render_async("users")
      end
    end

    context "called with html hash inside options hash" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            :container_id => /render_async_/,
            :path => "users",
            :html_options => { :nonce => "jkg1935safd" },
            :event_name => nil,
            :placeholder => nil
          }
        )

        helper.render_async("users", :nonce => "jkg1935safd")
      end
    end

    context "event_name is given inside options hash" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            :container_id => /render_async_/,
            :path => "users",
            :html_options => {},
            :event_name => "render_async_done",
            :placeholder => nil
          }
        )

        helper.render_async("users", :event_name => "render_async_done")
      end
    end

    context "placeholder is given" do
      let(:placeholder) { "I'm a placeholder" }

      before do
        allow(helper).to receive(:capture).and_return(placeholder)
      end

      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            :container_id => /render_async_/,
            :path => "users",
            :html_options => {},
            :event_name => nil,
            :placeholder => placeholder
          }
        )

        helper.render_async("users") { placeholder }
      end
    end
  end
end
