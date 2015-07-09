# FipeApi

This application is a ruby client to the Tabela Fipe Api - http://www.fipe.org.br/pt-br/indices/veiculos/. It makes use the excellent http gem to make http requests and nokogiri to parse the response

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fipe_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fipe_api

## Usage

The base class to use is a FipeApi::Vehicle. The Fipe data makes use of three Vehicles types wich are mapped to a FipeApi::Vehicle constant. The constants are:

FipeApi::Vehicle::CAR
FipeApi::Vehicle::MOTORCYCLE
FipeApi::Vehicle::TRUCK

You can get all Vehicles types with:

```ruby
vehicles = FipeApi::Vehicle.all
```

You can access the first vehicle like this:

```ruby
vehicles.first.id => 1
vehicles.first.name => Car
```

or you can initialize an specific Vehicle type, let`s say a CAR, with:

```ruby
vehicle = FipeApi::Vehicle.new(Vehicle::CAR, "Car")
```

Given a vehicle you can get all of its tables. A Table is generated each month with updated values for some vehicles. So, to get all tables you may do:

```ruby
tables = vehicle.get_tables 
```

Frequently you will be using the latest table generated, i.e. that was generated for the current month and year, to get the vehicles data. It`s possible to
retrieve the latest table for an specific vehicle with:

```ruby
latest_table = Table.latest(vehicle)
```

or you can get a table for an specific month and year:

```ruby
table = Table.find_by_month_and_year(vehicle, 3, 2015) # Table from March/2015
```

Once you have a vehicle and a given table, you can get all of the vehicle`s Brands(Ford, Fiat, GM/Chevrolet, BMW, etc...), like so:

```ruby
brands = vehicle.get_brands(table) #If you don`t pass a table, it will use the latest table for the vehicle.
```

Now you can retrieve all Models for an specific brand. For the Ford brand we have as examples of models: Fiesta, Fusion, Taurus, etc. Use this syntax to get
all models:

```ruby
models = brand.get_models(table) #If you don`t pass a table, it will use the latest table for the vehicle.
```

Now, let`s get the years of a model. Examples of years, for a Ford Fusion Titanium 2.0 GTDI EcoBo. Awd Aut, are: Zero KM Gasolina, 2015 Gasolina, 2014 Gasolina, 2013 Gasolina.
You can get the years with:

```ruby
years = model.get_years(table) #If you don`t pass a table, it will use the latest table for the vehicle.
``` 

Finally, once you have an specific year for a vehicle, it`s possible to get its price like the following:

```ruby
result = year.get_result(table) #If you don`t pass a table, it will use the latest table for the vehicle.

# Result of type FipeApi::FipeResult
result.price # => R$ 124.638,00
result.authentication # => g1gj386ctbp
result.year # => FipeApi::Year(month: 7, year: 2015)
result.fuel # => Gasolina
result.query_time # => quinta-feira, 9 de julho de 2015 09:54:03
result.url #=> http://www.fipe.org.br/pt-br/indices/veiculos/carro/ford/7-2015/003376-6/32000/g/g1gj386ctbp
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fipe_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
