require 'kahuna/member_collection'
require 'kahuna/member'
require 'spec_helper'

describe Kahuna::MemberCollection do
  subject { Kahuna::MemberCollection }
  it { should include(Enumerable) }

  describe 'instance' do
    let(:member_data) { "brandon.local    127.0.0.1    web" }
    let(:member)      { build :member }
    let(:member2)     { build :member }
    let(:member3)     { build :member }
    let(:data)        { '' }
    let(:mcollection) { Kahuna::MemberCollection.new data }

    subject { mcollection }

    it { should respond_to :raw_data }
    # it { should respond_to :members }
    it { should respond_to :empty? }

    describe '#new' do
      let(:data) {
        <<-EOL
          #{member.raw_data}
          #{member2.raw_data}
          #{member3.raw_data}
        EOL
      }

      it 'creates members from data' do
        mcollection.length.should eq 3
      end
    end

    describe '#each' do

      it 'yields each member if members are present' do
        [member, member2, member3].each { |m| mcollection << m }
        expect { |b| mcollection.each(&b) } .to yield_successive_args(member, member2, member3)
      end

      it 'does not yield if no members are present' do
        expect { |b| mcollection.each(&b) } .not_to yield_control
      end
    end

    describe '#length' do
      it 'should return 0 if there are no members' do
        mcollection.length.should eq 0
      end

      it 'should return the correct number of members in the collection' do
        1.upto(10) do |n|
          mcollection << member
          mcollection.length.should eq n
        end
      end
    end

    describe '#empty?' do
      it 'returns true if there are no members' do
        mcollection.should be_empty
      end

      it 'returns false if these are members in the collection' do
        mcollection << member
        mcollection.should_not be_empty
      end
    end

    describe "#<<" do

      before :each do
        mcollection << member
      end

      it "adds a new member to the collection" do
        mcollection.to_a.should eq [member]
      end

      # this is a member collection after all
      it "throws an exception if arguement is not a kind of Member" do
        expect {mcollection << ''} .to raise_error RuntimeError
      end
    end
  end
end
