module FipeApi
  class FipeResult < FipeApi::Base
    attr_accessor :id
    attr_accessor :authentication
    attr_accessor :year
    attr_accessor :fuel
    attr_accessor :price
    attr_accessor :query_time

    def initialize(id, year, fuel, authentication, price, query_time)
      self.id = id
      self.authentication = authentication
      self.year = year
      self.fuel = fuel
      self.price = price
      self.query_time = query_time
    end
  end
end
