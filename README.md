# Tinkoff

Updated fork of https://github.com/dankimio/tinkoff

What's new: 
1. New REST V2 API endpoint (https://securepay.tinkoff.ru/v2) support
2. Rails 4+ compatibility

Not all operations implemented fully.
Please refer to https://oplata.tinkoff.ru/landing/develop/documentation and read the code!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tinkoff', :git => 'git@github.com:/aristofun/tinkoff.git'
```


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
Tinkoff::Client.init(42, 16900, 
                      CustomerKey: user.id,
                      DATA: {Email: 'user@example.com'},
                      Description: description)

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

if notification.payment_confirmed?
  order = Order.find(notification.get('OrderId')) 
  order.update_attribute(:paid, true)
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dankimio/tinkoff. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
