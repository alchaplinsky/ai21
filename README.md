# Ruby client for AI21

Use the [Studio AI21](https://www.ai21.com/studio) API with Ruby! Differentiate your product with generative text AI :robot:.

## Installation

### Gem install
Install gem with:

```
gem install ai21
```

and require with:

```ruby
require "ai21"
```

### Bundler
Add gem to your application's `Gemfile`:

```ruby
gem "ai21"
```

And then execute:

```
bundle install
```

## Getting Started

- Sign up for AI21 Studio here https://studio.ai21.com/sign-up
- Get your API key from https://studio.ai21.com/account/api-key

## Usage

Instantiate a client
```ruby
client = AI21::Client.new "YOUR_API_TOKEN"
```

#### Completion
```ruby
client.complete("The capital of France is ")
```

#### Intstruct
```ruby
client.instruct("Tell me the name of main character in 'The Matrix'")
```

#### Paraphrase
```ruby
client.paraphrase("there is nothing that can't be fixed")
```

#### Correction
```ruby
client.correct("can you fix this speling mistake?")
```

#### Improvements
```ruby
client.improvements("This is a bad decision to let AI control the world")
```

#### Summarization
```ruby
client.summarize("Long text that requires summarization ...")
```

#### Question Answering
```ruby
client.answer("what is the capital of France?", "Capital of France is the city called Paris")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alchaplinsky/ai21. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/alchaplinsky/ai21/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Ai21 project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alchaplinsky/ai21/blob/main/CODE_OF_CONDUCT.md).
