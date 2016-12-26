module FipeApi
  class Vehicle < FipeApi::Base
    CAR = 1
    MOTORCYCLE = 2
    TRUCK = 3

    attr_accessor :id
    attr_accessor :name

    def initialize(id, name)
      self.id = id
      self.name = name
    end

    def self.all
      [Vehicle.new(CAR, "Car"),
       Vehicle.new(MOTORCYCLE, "Motorcycle"),
       Vehicle.new(TRUCK, "Truck")]
    end

    def get_tables
      Table.all(self)
    end

    def get_brands(table = nil)
      if table.nil?
        table = Table.latest(self)
      end

      response = HTTP.post("http://veiculos.fipe.org.br/api/veiculos/ConsultarMarcas", headers: HEADERS, params: { codigoTabelaReferencia: table.id, codigoTipoVeiculo: self.id }, body: {}.to_json).to_s
      brands_hash = JSON.parse(response)
      brands_result = []
      brands_hash.each do |brand|
        brands_result << Brand.new(brand["Value"], brand["Label"], table, self)
      end

      brands_result
    end

    def name_id
      case id
      when CAR
        return "carro"
      when MOTORCYCLE
        return "moto"
      when TRUCK
        return "caminhao"
      end
    end
  end
end
