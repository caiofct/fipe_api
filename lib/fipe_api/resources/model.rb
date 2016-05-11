module FipeApi
  class Model < FipeApi::Base
    attr_accessor :id
    attr_accessor :name
    attr_accessor :brand

    def initialize(id, name, brand)
      self.id = id
      self.name = name
      self.brand = brand
    end

    def get_years(table = nil)
      if table.nil?
        table = Table.latest(self.brand.vehicle)
      end

      response = HTTP.post("http://veiculos.fipe.org.br/api/veiculos/ConsultarAnoModelo",
                 params: {
                    codigoTabelaReferencia: table.id,
                    codigoTipoVeiculo: self.brand.vehicle.id,
                    codigoMarca: self.brand.id,
                    codigoModelo: self.id,
                 },
                 body: {}.to_json).to_s
      years_hash = JSON.parse(response)
      years_result = []
      years_hash.each do |year|
        years_result << Year.new(year["Value"], year["Label"], self)
      end

      years_result
    end
  end
end
