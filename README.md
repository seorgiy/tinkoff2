# Tinkoff

This is a Rails 4.2+ fork of https://github.com/dankimio/tinkoff

For new REST V2 API endpoint (https://securepay.tinkoff.ru/v2)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tinkoff', :git => 'git@github.com:/aristofun/tinkoff.git'
```

Now you can use it in Rails 4.2+ projects.

Everything else is the same as [original gem](https://github.com/dankimio/tinkoff)

## Usage

Configure the gem with the credentials provided by the bank. If you are using Ruby on Rails, you should do that in an initializer.

```ruby
# config/initializers/tinkoff.rb
Tinkoff.configure do |config|
  config.terminal_key = 'TerminalKey'
  config.password = 'Password'
end
```

Use the client to work with payments.

```ruby
# Parameters: amount (in kopecks), order_id, data, options (hash, optional)
# data — a hash of arbitrary data (up to 20 pairs), "Email" key is required
# More info: https://oplata.tinkoff.ru/documentation/?section=Init
Tinkoff::Client.init(100, 1, { Email: 'foo@bar.com' })

# Parameters: payment_id, options (hash, optional)
Tinkoff::Client.confirm(1)

# Parameters: payment_id, rebill_id, options (hash, optional)
Tinkoff::Client.charge(1, 2)

# Parameters: payment_id, options (hash, optional)
Tinkoff::Client.cancel(1)

# Parameters: payment_id, options (hash, optional)
Tinkoff::Client.state(1)
```

You can view all available options in the [official documentation](https://oplata.tinkoff.ru/documentation/?section=aboutMet).

A notification will be sent to if you provided the URL. You should use it to update the status of your payment / order.

```ruby
notification = Tinkoff::Notification.new(params)
order = Order.find(notification.order_id)
order.update_attribute(:paid, true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dankimio/tinkoff. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
