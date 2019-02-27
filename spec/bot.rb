require './handlers'
require './bot_request'

RSpec.describe ExistsHandler do
  before(:each) do
    @bot_request = BotRequest.new('rails', nil)
    @chain = ExistsHandler.new
  end

  describe "#handle" do
    it "when valid" do
      expect(@chain.call(@bot_request)).to eq('Gem exists')
    end

    it 'when fail' do
      @bot_request = BotRequest.new('lolkekcheburek', nil)
      expect(@chain.call(@bot_request)).to eq('Gem hasn\'t found')
    end
  end
end

RSpec.describe LatestHandler do
  before(:each) do
    @bot_request = BotRequest.new('rails', 'latest')
    @chain = LatestHandler.new
  end

  describe "#handle" do
    it "when valid" do
      expect(@chain.call(@bot_request)).to eq('5.2.2')
    end

  end
end
