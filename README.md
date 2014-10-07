# GlobalStore

Many applications need to use variables that are state local; quite often, the resulting code is polluted with references to Thread.current. After a while, no one is sure what is stored there, where it is used, and why it has to be there in the first place.
Therefore, you might have to wrap Thread.current into something more sensible.

For Rails, the request_store gem is an example of a nice wrapper over Thread.current that makes sure all the variables are cleared after the request processing is finished - it achieves this via middleware.

I quickly built a wrapper over RequestStore as I might have to switch to a different store and I would like to configure key prefixes.

## Installation

Add this line to your application's Gemfile:

    gem 'global_store'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install global_store

## Usage

### Configuration

require 'global_store'

```ruby

GlobalStore.configure do |config|

  # specify the key prefix, defaults to "global_store"
  config.key_prefix = "my_custom_prefix"
  # specify what will store your variables in a key-value manner, defaults to RequestStore
  config.store = RequestStore

end
```

### Using the global_store

```ruby

# set stuff
GlobalStore::Store[:key] = :my_value
# get stuff
GlobalStore::Store[:key] # :my_value
# check if a key exists
GlobalStore::Store.exists?(:key) # true

```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/global_store/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
