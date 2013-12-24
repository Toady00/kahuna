require 'kahuna/handler'

describe Kahuna::Handler do

  describe 'instance' do
    let(:name)    { "brandon.local" }
    let(:address) { "127.0.0.1" }
    let(:role)    { "web" }
    let(:data)    { "#{name}    #{address}    #{role}" }
    let(:handler) { Kahuna::Handler.new data }

    subject { handler }

    it { should respond_to :event }
    it { should respond_to :members }
    it { should respond_to :execute }

    describe '#execute' do
      let(:block) { ->(event, members) { true } }

      it 'calls the action' do
        Proc.any_instance.should_receive(:call).with(handler.event, handler.members)
        handler.execute
      end

      it 'allows arbitary blocks to be passed in' do
        handler = Kahuna::Handler.new data, &block
        Proc.any_instance.should_receive(:call).with(handler.event, handler.members)
        handler.execute
      end
    end
  end
end
