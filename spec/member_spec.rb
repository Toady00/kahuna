require 'kahuna/member'

describe Kahuna::Member do
  let(:name)    { "brandon.local" }
  let(:address) { "127.0.0.1" }
  let(:role)    { "web" }
  let(:data)    { "#{name}    #{address}    #{role}" }
  let(:member)  { Kahuna::Member.new data }

  subject { member }

  it { should respond_to :name }
  it { should respond_to :address }
  it { should respond_to :role }
  it { should respond_to :raw_data }

  it 'should assign the correct values' do
    member.name.should eq(name)
    member.address.should eq(address)
    member.role.should eq(role)
  end
end
