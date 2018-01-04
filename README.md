# Lockme

[![Build Status](https://travis-ci.org/hajder/lockme.svg?branch=master)](https://travis-ci.org/hajder/lockme)
[![Maintainability](https://api.codeclimate.com/v1/badges/d14d98a40a58ca93238a/maintainability)](https://codeclimate.com/github/hajder/lockme/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d14d98a40a58ca93238a/test_coverage)](https://codeclimate.com/github/hajder/lockme/test_coverage)
[![Gem](https://img.shields.io/gem/v/lockme.svg)](https://rubygems.org/gems/lockme)

Lockme is a Ruby gem to interact with [lockme.pl](https://lockme.pl) API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lockme'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lockme

## Usage

After adding the gem you need to initialize it with your API key and secret

```ruby
Lockme.api_key = '...'
Lockme.secret = '...'
```

If you wish to debug the requests sent set `Lockme.logger` to `$stdout` or `Rails.logger` if you use this gem inside a Rails app.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hajder/lockme.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

