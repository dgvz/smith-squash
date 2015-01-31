# Smith::Squash

Integrate squash into your smith agents.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smith-squash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smith-squash

## Usage

This requires you to setup the following environment variables for your agents:
* `SQUASH_URI`: The URI of your squash installation
* `SQUASH_API_KEY`: The API key setup for your squash project

If neither of these are set then squash just won't log, so that means you don't
have to worry about any `if production` logic.

Optionally you can set the follow environment variables:
* `SQUASH_SKIP_SSL_VERIFICATION=true`: to skip ssl verification if your
  certificate is suck
* `REVISION_FILE_PATH`: if set squash reads this file to get the current
  revision. You only need this if it's not a git repo

If you want your agent to send messages to squash on an uncaught exception just
setup your agent as follows:

```ruby
require 'smith/squash/squashable_agent'

class MyAgent < Smith::Agent
  include SquashableAgent

  def run
    enable_squash
  end
end
```

Or if you want to send specific errors to squash you can do:

```
require 'smith/squash/squashable_agent'

class MyAgent < Smith::Agent
  include SquashableAgent

  def run
  end

  def do_something(arg)
    df = do_deferred

    df.errback do |e|
      squash_notify(e, {:arg => arg})
    end
  end
end
```


## Contributing

1. Fork it ( https://github.com/dgvz/smith-squash/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
