require 'kahuna/member_collection'

module Kahuna
  class Event
    attr_reader :type, :name, :role, :user_event, :user_ltime, :members

    def initialize(data)
      @type = ENV['SERF_EVENT']
      @name = ENV['SERF_SELF_NAME']
      @role = ENV['SERF_SELF_ROLE']
      @user_event = ENV['SERF_USER_EVENT']
      @user_ltime = ENV['SERF_USER_LTIME']
      @members = process_members data
    end

  private
    def process_members(data)
      MemberCollection.new(data) if MemberCollection::EVENTS.include? type
    end
  end
end
