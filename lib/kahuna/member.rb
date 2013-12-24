module Kahuna
  class Member
    attr_reader :name, :address, :role, :raw_data
    REGEX = /([\w\.\-]+)\s+([\w\.\-]+)\s+([\w\.\-]+)/
    EVENTS = %w(member-join member-leave member-failed)

    def initialize(data)
      @raw_data = data
      @name, @address, @role = process_data
    end

  private
    def process_data
      @raw_data.match(REGEX).captures
    end
  end
end
