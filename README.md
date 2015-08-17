# YahooGeminiClient

Ruby wrapper for the Yahoo! Gemini API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yahoo_gemini_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yahoo_gemini_client

## Usage
Currently supports OAuth2 Auth Code Strategy (Explicit Grant Flow) only.
For more info see https://developer.yahoo.com/oauth2/guide/flows_authcode/

### Getting a refresh token

Your app can start using this gem if you have a refresh token.
A refresh token can be manually generated through the console.

```ruby
client = YahooGeminiClient::Client.new(
  consumer_key: "consumer_key",
  consumer_secret: "consumer_secret",
)

# open a browser and go to the authorization url given to get the authorization code
authorization_url = client.authorization_url

# you can now generate the refresh token once you have the authorization code
refresh_token = client.get_token("the_authorization_code").refresh_token

# with the refresh token you can now instantiate and use a YahooGeminiClient::Client anytime
client = YahooGeminiClient::Client.new(
  consumer_key: "consumer_key",
  consumer_secret: "consumer_secret",
  refresh_token: refresh_token,
)
```

### Advertisers

#### Retrieving

```ruby
  response = client.advertisers.find(123)
  response.error? # check if response is error
  response.advertiser # returns a YahooGeminiClient::Advertiser
```

### Custom Reports

#### Requesting Yahoo.com to create a custom report with a given cube

```ruby
  request_body = { "cube": "performance_stats",
    "fields": [
      { "field": "Ad ID" },
      { "field": "Day" },
      { "alias": "My dummy column", "value": "" },
      { "field": "Impressions" },
      { "field": "Ad Image URL", "alias": "url" }
    ],

    "filters": [
      { "field": "Advertiser ID", "operator": "=", "value": 12345 },
      { "field": "Campaign ID", "operator": "IN", "values": [10,20,30] },
      { "field": "Day", "operator": "between", "from": "2014-04-01", "to": "2014-04-30" }
    ]
  }

  response = client.custom_report.create(request_body)
  response.error? # check if response is error
  response.job_id # get the report request token of the report creation job request at Yahoo.com
```

#### Checking the status of the requested report from Yahoo.com

```ruby
  params = {advertiser_id: 12345, job_id: "86ea9ba1c645e7a33bddfc06ee5c799fa40d02ce49632927"}
  response = client.custom_report.find(params)
  response.error? # check if response is error
  response.completed? # check if report creation at Yahoo.com is complete
  response.csv_url # get the csv url of the created report
```

### Campaigns

#### Fetching campaigns for an advertiser

```ruby
  params = {advertiser_id: 12345}
  response = client.campaigns.where(params)
  response.campaigns # returns Array[YahooGeminiClient::Campaign]
```

## Creating a Test Yahoo Gemini Account (For Testing)

1. Sign in using any given Yahoo Mail Account and go to `https://gemini.yahoo.com/advertiser/home`
2. Press "Sign Up" to create a Yahoo Gemini Account.
3. From here, you can create an advertiser and corresponding campaigns

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/g5/yahoo_gemini_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

Copyright (c) 2015 G5

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
