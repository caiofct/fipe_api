module FipeApi
  class Brand < FipeApi::Base
    attr_accessor :id
    attr_accessor :name
    attr_accessor :vehicle
    attr_accessor :table

    def initialize(id, name, table, vehicle)
      self.id = id
      self.name = name
      self.table = table
      self.vehicle = vehicle
    end

    def get_models(table = nil)
      if table.nil?
        table = Table.latest(self.vehicle)
      end

      response = HTTP.post("http://veiculos.fipe.org.br/api/veiculos/ConsultarModelos",
                 headers: HEADERS,
                 params: {
                    codigoTabelaReferencia: table.id,
                    codigoTipoVeiculo: self.vehicle.id,
                    codigoMarca: self.id
                 },
                 body: {}.to_json).to_s
      models_hash = JSON.parse(response)
      models_result = []
      models_hash["Modelos"].each do |model|
        models_result << Model.new(model["Value"], model["Label"], self)
      end

      models_result
    end
  end
end
