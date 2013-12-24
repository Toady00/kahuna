module Kahuna
  class Event
    attr_reader :raw_data, :type, :name, :role, :user_event, :user_ltime

    def initialize(data)
      @raw_data = data
      @type = ENV['SERF_EVENT']
      @name = ENV['SERF_SELF_NAME']
      @role = ENV['SERF_SELF_ROLE']
      @user_event = ENV['SERF_USER_EVENT']
      @user_ltime = ENV['SERF_USER_LTIME']
    end
  end
end
