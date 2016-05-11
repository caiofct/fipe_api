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

    #http://www.fipe.org.br/pt-br/indices/veiculos/carro/ford/7-2015/003376-6/32000/g/g1gj386ctbp
    def url
      "http://www.fipe.org.br/pt-br/indices/veiculos/#{year.model.brand.vehicle.name_id}/" +
      "#{year.model.brand.name.downcase}/#{year.model.brand.table.month}-#{year.model.brand.table.year}/" +
      "#{self.id}/#{self.year.id}/g/#{self.authentication}"
    end
  end
end
