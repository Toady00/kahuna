require 'kahuna/event'
require 'kahuna/member_collection'

module Kahuna
  class Handler
    attr_reader :event, :members

    def initialize(data, &block)
      @event = Event.new data
      unless event.type == 'user'
        @members = MemberCollection.new data
      end
      @action = block_given? ? block : ->(event, members) {}
    end

    def execute &block
      block_to_call = block_given? ? block : @action
      block_to_call.call(event, members)
    end
  end
end
