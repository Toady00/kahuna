require 'kahuna/event'
require 'kahuna/member_collection'

module Kahuna
  class Handler
    attr_reader :event, :members

    # def self.build
    #   klass = Class.new(BasicObject) do
    #     def inspect
    #       "<handler>"
    #     end

    #     klass = self
    #     define_method(:class) { klass }
    #   end

    #   builder = ActionClassBuilder.new(klass)
    #   yield(builder) if block_given?
    #   unless builder.interface_defined?
    #     builder.respond_to_missing_with_nil
    #   end
    #   klass
    # end

    def initialize(data, &block)
      @event = Event.new data
      unless event.type == 'user'
        @members = MemberCollection.new data
      end
      @action = block_given? ? block : ->(event, members) {}
    end

    # def to_string
    #   <<-EOF
    #     DATA: #@data
    #     EVENT: #@event
    #     NAME: #@name
    #     ROLE: #@role
    #     USER EVENT: #@user_event
    #     LAMPORT TIME: #@lamport_time
    #   EOF
    # end

    def execute
      @action.call(event, members)
    end
  end
end
