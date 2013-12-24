require 'kahuna/member'

module Kahuna
  class Event
    attr_reader :data, :type, :name, :role, :user_event, :user_ltime

    def initialize(data)
      @data = data
      @type = ENV['SERF_EVENT']
      @name = ENV['SERF_SELF_NAME']
      @role = ENV['SERF_SELF_ROLE']
      @user_event = ENV['SERF_USER_EVENT']
      @user_ltime = ENV['SERF_USER_LTIME']
      process_members
    end

    def members
      @members ||= []
    end

  private
    def process_members
      if Member::EVENTS.include? type
        add_member(Member.new self.data)
      end
    end

    def add_member(member)
      members << member
    end
  end
end
