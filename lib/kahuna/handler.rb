require 'kahuna/event'
require 'kahuna/member_collection'

module Kahuna
  class Handler
    attr_reader :event, :members

    def initialize(data, &block)
      @event   = Event.new data
      @members = build_member_collection data
      @action  = block_given? ? block : ->(event, members) {}
    end

    def execute &block
      block_to_call = block_given? ? block : @action
      block_to_call.call(event, members)
    end

  private
    def build_member_collection(data)
       if event.type == 'user'
        []
      else
        MemberCollection.new data
      end
    end
  end
end
