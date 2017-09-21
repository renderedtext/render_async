require "spec_helper"

describe RenderAsync::ViewHelper do
  let(:helper) { Class.new { extend RenderAsync::ViewHelper } }

  describe "#render_async_cache_key" do
    it "returns cache key" do
      expect(helper.render_async_cache_key("users")).to eq("render_async_users")
    end
  end

  describe "render_async" do
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
            :placeholder => nil
          }
        )

        helper.render_async("users")
      end
    end

    context "called with html_options" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            :container_id => /render_async_/,
            :path => "users",
            :html_options => { :nonce => "jkg1935safd" },
            :placeholder => nil
          }
        )

        helper.render_async("users", :nonce => "jkg1935safd")
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
            :placeholder => placeholder
          }
        )

        helper.render_async("users") do
          placeholder
        end
      end
    end
  end
end
