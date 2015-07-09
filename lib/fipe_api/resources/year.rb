module FipeApi
  class Year < FipeApi::Base
    attr_accessor :id
    attr_accessor :name
    attr_accessor :model
    attr_accessor :fuel

    def initialize(id, name, model)
      self.id = id.split("-")[0]
      self.fuel = id.split("-")[1]
      self.name = name
      self.model = model
    end

    def get_result(table = nil)
      if table.nil?
        table = Table.latest(self.model.brand.vehicle)
      end

      response = HTTP.post("http://www.fipe.org.br/IndicesConsulta-ConsultarValorComTodosParametros",
                 params: {
                    codigoTabelaReferencia: table.id,
                    codigoTipoVeiculo: self.model.brand.vehicle.id,
                    codigoMarca: self.model.brand.id,
                    codigoModelo: self.model.id,
                    anoModelo: self.id,
                    codigoTipoCombustivel: self.fuel,
                    tipoVeiculo: self.model.brand.vehicle.name_id,
                    tipoConsulta: "tradicional"
                 },
                 body: {}.to_json).to_s
      result_json = JSON.parse(response)
      fipe_result = nil
      if !result_json.nil?
        fipe_result = FipeResult.new(result_json["CodigoFipe"],
                                     self,
                                     result_json["Combustivel"],
                                     result_json["Autenticacao"],
                                     result_json["Valor"],
                                     result_json["DataConsulta"])
      end

      fipe_result
    end
  end
end
