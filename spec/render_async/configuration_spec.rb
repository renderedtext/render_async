require "spec_helper"

describe RenderAsync::Configuration do
  it 'initializes jquery setting to false' do
    expect(RenderAsync::Configuration.new.jquery).to eq false
  end
end
