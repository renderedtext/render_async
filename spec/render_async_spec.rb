require "spec_helper"

describe RenderAsync do
  describe '.configuration' do
    it 'initializes jquery setting to false' do
      expect(RenderAsync.configuration.jquery).to eq false
    end

    it 'initializes turbolinks setting to false' do
      expect(RenderAsync.configuration.turbolinks).to eq false
    end

    it 'initializes turbo setting to false' do
      expect(RenderAsync.configuration.turbo).to eq false
    end
  end

  describe '.reset' do
    it 'resets jquery setting to false' do
      RenderAsync.configuration.jquery = true

      RenderAsync.reset

      expect(RenderAsync.configuration.jquery).to eq false
    end
  end

  describe '.configure' do
    it 'sets jquery value' do
      RenderAsync.configure do |config|
        config.jquery = true
      end

      expect(RenderAsync.configuration.jquery).to eq true
    end
  end
end
