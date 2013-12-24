require 'kahuna/event'
require 'kahuna/member'

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

  it { should respond_to :data }
  it { should respond_to :type }
  it { should respond_to :name }
  it { should respond_to :role }
  it { should respond_to :user_event }
  it { should respond_to :user_ltime }

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

    env_map.each do |attribute, env_var_name|
      it "should set #{attribute} from ENV[#{env_var_name}" do
        expect(@event.send attribute).to eq(ENV[env_var_name])
      end
    end

    it 'create a members array from the event' do
      @event.members.first.should be_a Kahuna::Member
    end

    it 'sanity check' do
      expect(@event.data).to be data
    end
  end
end
