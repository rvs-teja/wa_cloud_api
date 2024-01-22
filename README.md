# WaCloudApi

WaCloudApi is a ruby gem that provides a convinient way to interact with Whatsapp Cloud API allowing developer to integrate Whatsapp messaging capabilities into Ruby / Rails applications.

# Installation
Install the gem and add to the application's Gemfile by executing:

```ruby
$ bundle add wa_cloud_api
```

If bundler is not being used to manage dependencies, install the gem by executing:

```ruby
$ gem install wa_cloud_api
```

# Usage

### Configuration

Before using the gem, you need to configure it with your WhatsApp Cloud API credentials. You can do this by using the following code:

```ruby
require 'wa_cloud_api'

WaCloudApi,configure do |config|
    config.phone_number_id = 'your_phone_number_id'
    config.token = 'your_token'
end
```

### Features

- Text Message

#### Text Message

To send a text message to a phone number. 

Parameters

1. `to`: (Required) The phone number of the recipient. It should be in international format
2. `body`: (Required) The actual text message you want to send
3. `preview_url`: (Optional) A boolean parameter whether a URL preview should be generated for the links in the message. By default it is set to false

```ruby
WaCloudApi::Message::Text.new(
  to: 'recipient_phone_number ', 
  body: 'This is a test message',
).deliver
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rvs-teja/wa_cloud_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/rvs-teja/wa_cloud_api/blob/main/CODE_OF_CONDUCT.md).
