module FipeApi
  class Table < FipeApi::Base
    attr_accessor :id
    attr_accessor :month
    attr_accessor :year

    def initialize(id, month, year)
      self.id = id
      self.month = month
      self.year = year
    end

    def self.all(vehicle)
      return [] if vehicle.nil?
      tables = []
      response = HTTP.post("http://veiculos.fipe.org.br/api/veiculos/ConsultarTabelaDeReferencia", body: {}.to_json).to_s
      tables_hash = JSON.parse(response)
      tables_hash.each do |table|
        if table["Mes"] != ""
          parts = table["Mes"].strip.split("/")
          tables << Table.new(table["Codigo"], Utils.month_name_to_int(parts[0]), parts[1].to_s)
        end
      end

      tables
    end

    def self.latest(vehicle)
      return nil if vehicle.nil? || !vehicle.kind_of?(FipeApi::Vehicle)
      table = nil
      response = HTTP.post("http://veiculos.fipe.org.br/api/veiculos/ConsultarTabelaDeReferencia", body: {}.to_json).to_s
      table = JSON.parse(response).first
      # first_option = doc.css("#selectTabelaReferencia#{vehicle.name_id} option").first
      if table["Mes"] != ""
        parts = table["Mes"].strip.split("/")
        table = Table.new(table["Codigo"], Utils.month_name_to_int(parts[0]), parts[1].to_s)
      end
      table
    end
  end
end
