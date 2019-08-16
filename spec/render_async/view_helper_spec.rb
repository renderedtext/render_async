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
                               html_safe: "<h1>I'm cache</h1>",
                               present?: true) }
    before do
      stub_const("Rails", double("Rails"))
    end

    context "cache is present" do
      before do
        allow(Rails).to receive_message_chain(:cache, :read).and_return(cached_view)
      end

      it "renders cached HTML" do
        expect(helper).to receive(:render).with(
          html: "<h1>I'm cache</h1>"
        )

        helper.render_async_cache("users")
      end
    end

    context "cache is not present" do
      let(:empty_cache) { double("EmptyCache", present?: false) }

      before do
        allow(Rails).to receive_message_chain(:cache, :read).and_return(empty_cache)
      end

      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            html_element_name: "div",
            container_id: /render_async_/,
            container_class: nil,
            path: "users",
            html_options: {},
            event_name: nil,
            toggle: nil,
            placeholder: nil,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: nil
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
            html_element_name: "div",
            container_id: /render_async_/,
            container_class: nil,
            path: "users",
            html_options: {},
            event_name: nil,
            toggle: nil,
            placeholder: nil,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: nil
          }
        )

        helper.render_async("users")
      end
    end

    context "container_id is given inside options hash" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            html_element_name: "div",
            container_id: "users-container",
            container_class: nil,
            path: "users",
            html_options: {},
            event_name: nil,
            toggle: nil,
            placeholder: nil,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: nil
          }
        )

        helper.render_async("users", container_id: "users-container")
      end
    end

    context "container_class is given inside options hash" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            html_element_name: "div",
            container_id: /render_async_/,
            container_class: 'users-placeholder',
            path: "users",
            html_options: {},
            event_name: nil,
            toggle: nil,
            placeholder: nil,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: nil
          }
        )

        helper.render_async("users", container_class: "users-placeholder")
      end
    end

    context "html_element_name is given inside options hash" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            html_element_name: "tr",
            container_id: /render_async_/,
            container_class: nil,
            path: "users",
            html_options: {},
            event_name: nil,
            toggle: nil,
            placeholder: nil,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: nil
          }
        )

        helper.render_async("users", html_element_name: "tr")
      end
    end

    context "called with html hash inside options hash" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            html_element_name: "div",
            container_id: /render_async_/,
            container_class: nil,
            path: "users",
            html_options: { nonce: "jkg1935safd" },
            event_name: nil,
            toggle: nil,
            placeholder: nil,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: nil
          }
        )

        helper.render_async("users", nonce: "jkg1935safd")
      end
    end

    context "event_name is given inside options hash" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            html_element_name: "div",
            container_id: /render_async_/,
            container_class: nil,
            path: "users",
            html_options: {},
            event_name: "render_async_done",
            toggle: nil,
            placeholder: nil,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: nil
          }
        )

        helper.render_async("users", event_name: "render_async_done")
      end
    end

    context "toggle is given inside options hash" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            html_element_name: "div",
            container_id: /render_async_/,
            container_class: nil,
            path: "users",
            html_options: {},
            event_name: nil,
            toggle: { selector: 'el-id', event: :click },
            placeholder: nil,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: nil
          }
        )

        helper.render_async("users", toggle: { selector: 'el-id', event: :click })
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
            html_element_name: "div",
            container_id: /render_async_/,
            container_class: nil,
            path: "users",
            html_options: {},
            event_name: nil,
            toggle: nil,
            placeholder: placeholder,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: nil
          }
        )

        helper.render_async("users") { placeholder }
      end
    end

    context "JSON POST request" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            html_element_name: "div",
            container_id: /render_async_/,
            container_class: nil,
            path: "users",
            html_options: {},
            event_name: nil,
            toggle: nil,
            placeholder: nil,
            method: 'POST',
            data: { 'foor' => 'bar' }.to_json,
            headers: { 'Content-Type' => 'application/json' },
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: nil
          }
        )

        helper.render_async(
          "users",
          method: 'POST',
          data: { 'foor' => 'bar' }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      end
    end

    context "retry_count is given" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            html_element_name: "div",
            container_id: /render_async_/,
            container_class: nil,
            path: "users",
            html_options: {},
            event_name: nil,
            toggle: nil,
            placeholder: nil,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 5,
            interval: nil
          }
        )

        helper.render_async(
          "users",
          retry_count: 5
        )
      end
    end

    context "interval is given" do
      it "renders render_async partial with proper parameters" do
        expect(helper).to receive(:render).with(
          "render_async/render_async",
          {
            html_element_name: "div",
            container_id: /render_async_/,
            container_class: nil,
            path: "users",
            html_options: {},
            event_name: nil,
            toggle: nil,
            placeholder: nil,
            method: 'GET',
            data: nil,
            headers: {},
            error_message: nil,
            error_event_name: nil,
            retry_count: 0,
            interval: 5000
          }
        )

        helper.render_async(
          "users",
          interval: 5000
        )
      end
    end
  end
end
