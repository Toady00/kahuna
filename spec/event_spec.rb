require 'kahuna/event'

describe Kahuna::Event do
  env_map = {
    type: 'SERF_EVENT',
    name: 'SERF_SELF_NAME',
    role: 'SERF_SELF_ROLE',
    user_event: 'SERF_USER_EVENT',
    user_ltime: 'SERF_USER_LTIME'
  }

  let(:data)    { "Some Data" }
  let(:event)   { Kahuna::Event.new data }

  subject { event }

  it { should respond_to :type }
  it { should respond_to :name }
  it { should respond_to :role }
  it { should respond_to :user_event }
  it { should respond_to :user_ltime }
  it { should respond_to :members }

  describe "membership events" do
    let(:name)    { "brandon.local" }
    let(:address) { "127.0.0.1" }
    let(:role)    { "web" }
    let(:data)    { "#{name}    #{address}    #{role}" }

    before(:each) do
      ENV['SERF_EVENT']     = "member-join"
      ENV['SERF_SELF_NAME'] = name
      ENV['SERF_SELF_ROLE'] = role
      @event = Kahuna::Event.new data
    end

    # TODO: Pull out into shared context
    env_map.each do |attribute, env_var_name|
      it "should set #{attribute} from ENV[#{env_var_name}" do
        expect(@event.send attribute).to eq(ENV[env_var_name])
      end
    end

    it 'does not set user_event' do
      @event.user_event.should be_nil
    end

    it 'does not set the user_ltime' do
      @event.user_ltime.should be_nil
    end

    describe '#new' do
      it 'creates a member_collection from the event data' do
        @event.members.should be_a Kahuna::MemberCollection
      end
    end
  end

  describe 'user event' do
    let(:data) { "Kahuna Test Payload" }

    before(:each) do
      ENV['SERF_EVENT'] = "user"
      ENV['SERF_USER_EVENT'] = "kahuna_test"
      ENV['SERF_USER_LTIME'] = Time.now.utc.to_s
      @event = Kahuna::Event.new data
    end

    # TODO: Pull out into shared context
    env_map.each do |attribute, env_var_name|
      it "should set #{attribute} from ENV[#{env_var_name}" do
        expect(@event.send attribute).to eq(ENV[env_var_name])
      end
    end

    it 'does set the user_event' do
      @event.user_event.should eq(ENV['SERF_USER_EVENT'])
    end

    it 'does set the user_ltime' do
      @event.user_ltime.should eq(ENV['SERF_USER_LTIME'])
    end

    describe '#new' do
      it 'does not create a member collection' do
        @event.members.should be_nil
      end
    end
  end
end
