# Params Patrol

![Call for backup!](http://www.security-guard.ca/wp-content/uploads/2015/01/security-guard-patrol-service.jpg)

Keeps an eye out for suspicious parameters... and then calls for backup

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'params_patrol'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install params_patrol

## Usage

Builds off of `strong_parameters` (https://github.com/rails/strong_parameters) and is a required dependency. To use `ParamsPatrol` in your rails 3 app,

At the model level include

```ruby
include ActiveModel::SuppressForbiddenAttributes
```

and at the controller level include

```ruby
include ActionController::HandleUnpermittedParameters`
```

Also strong parameters needs to be set to raise an exception on unpermitted parameters which can be set in `config/application.rb` here,

```ruby
config.action_controller.action_on_unpermitted_parameters = :raise
```

Once this is set up, unpermitted parameters are logged by default. You can specify how you want to handle unpermitted parameters by defining a handler in `ParamsPatrol` like:

```ruby
ParamsPatrol.handle= lambda { |x| Logger.new(STDOUT).warn(x) }
```

in an initializer file.


## Contributors

- @npj
- kelly@indiegogo.com
- @indiebendix
- jenmei@indiegogo.com
- @aarongogo
- @gogojared
- @jcareyigg
- @indieblaine
- and others

## Contributing

1. Fork it ( https://github.com/IndieGoGo/params_patrol/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
