# Be::Data::Api

API client for [Data.be](http://api.data.be/)

## Installation

Add this line to your application's Gemfile:

    gem 'be-data-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install be-data-api

## Usage

```ruby
require 'be-data-api'

client = Be::Data::Api.new(API_ID, API_KEY)

client.vat_valid?("882381185")
# => true

client.vat_status("882381185")
# => #<struct Be::Data::Api::VatStatus vat_clean="0882381185", vat_formatted="BE 0882.381.185", active=true, valid=true>

client.vat_basic("882381185")
# => #<struct Be::Data::Api::VatBasic vat_clean="0882381185", vat_formatted="BE 0882.381.185", active=true, valid=true, company_name="Mr.Henry", start_date="2006-07-03", language="nl", address_fr="Veldenstraat 14, , 2470 Retie", address_nl="Veldenstraat 14, , 2470 Retie">
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
