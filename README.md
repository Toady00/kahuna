# Kahuna

A gem for handling [Serf](serfdom.io) events.

_(ka-hoo-na) Hawaiian term for a man that surfs usually with a degree of skill.
[from rippinh2o.com](http://rippinh2o.com/dropzone/surflingo.shtml#k)_

[![Build Status](https://travis-ci.org/Toady00/kahuna.png)](https://travis-ci.org/Toady00/kahuna) [![Gem Version](https://badge.fury.io/rb/kahuna.png)](http://badge.fury.io/rb/kahuna) [![Code Climate](https://codeclimate.com/github/Toady00/kahuna.png)](https://codeclimate.com/github/Toady00/kahuna) [![Dependency Status](https://gemnasium.com/Toady00/kahuna.png)](https://gemnasium.com/Toady00/kahuna)

## Installation

Add this line to your application's Gemfile:

    gem 'kahuna'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kahuna

## Example Usage

Create a file named ```handler``` like the file below.

```ruby
#!/usr/bin/env ruby

require 'kahuna'

data = ''
while line = Readline.readline('', true)
  data += line
end

Kahuna::Handler.new(data) do |event, members|
  # Code to execute in response to event
end.execute

exit 0
```

Make the file executable

```bash
$ chmod +x handler
```

Then pass the file to serf as a handler.

```bash
serf agent -event-handler ./handler
```

## Event and Members

[Kahuna::Handler](lib/kahuna/handler.rb) yields [Kahuna::Event](lib/kahuna/event.rb) and [Kahuna::MemberCollection](lib/kahuna/member_collection.rb) objects to the block passed to new. The Event object contains all the information about the event parsed from the data sent from Serf and the ENV vars set by Serf.

Serf _membership_ events contain information about the members that participated in the Serf event. This information is the payload for the Serf event, but for Serf _user_ events, the payload is arbitrary. In the case of user events, the current implementation yields ```nil``` for the members variable.

You can always get to the raw data sent from Serf through the event object, regardless of whether it is a user event or a membership event.

```ruby
event.raw_data        #=> "deploy all the things!"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
