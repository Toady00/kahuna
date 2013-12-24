require 'kahuna/member'

module Kahuna
  class MemberCollection
    include Enumerable

    EVENTS = %w(member-join member-leave member-failed)

    attr_reader :raw_data

    def initialize(data)
      @raw_data = data
      members_from_data raw_data
    end

    def each(&block)
      members.each do |member|
        block.call member
      end
    end

    def empty?
      length == 0
    end

    def length
      members.length
    end

    define_method("<<") do |member|
      raise "Not a kind of Kahuna::Member" unless member.kind_of? Member
      members << member
    end

  private
    def members
      @members ||= []
    end

    def members_from_data(raw_data)
      member_data = raw_data.split("\n").map { |data| data.strip }
      member_data.each do |data|
        member = Member.new data
        self << member
      end
    end
  end
end
