module FipeApi
  # Describes a Fipe Table whichi is generated each month with updated values for some vehicles
  class Table < FipeApi::Base
    attr_accessor :id
    attr_accessor :month
    attr_accessor :year

    # Constructor
    def initialize(id, month, year)
      self.id = id
      self.month = month
      self.year = year
    end

    # Gets all tables for an specific vehicle
    def self.all(vehicle)
      return [] if vehicle.nil?
      tables = []
      response = HTTP.post("http://veiculos.fipe.org.br/api/veiculos/ConsultarTabelaDeReferencia", headers: HEADERS, body: {}.to_json).to_s
      tables_hash = JSON.parse(response)
      tables_hash.each do |table|
        if table["Mes"] != ""
          parts = table["Mes"].strip.split("/")
          tables << Table.new(table["Codigo"], Utils.month_name_to_int(parts[0]), parts[1].to_i)
        end
      end

      tables
    end

    # Gets the latest table, for current month and year, for an specific vehicle
    def self.latest(vehicle)
      return nil if vehicle.nil? || !vehicle.kind_of?(FipeApi::Vehicle)
      table = nil
      response = HTTP.post("http://veiculos.fipe.org.br/api/veiculos/ConsultarTabelaDeReferencia", headers: HEADERS, body: {}.to_json).to_s
      table = JSON.parse(response).first
      # first_option = doc.css("#selectTabelaReferencia#{vehicle.name_id} option").first
      if table["Mes"] != ""
        parts = table["Mes"].strip.split("/")
        table = Table.new(table["Codigo"], Utils.month_name_to_int(parts[0]), parts[1].to_i)
      end
      table
    end

    # Gets a table for a certain month and year and for an specific vehicle
    def self.find_by_month_and_year(vehicle, month, year)
      return nil if vehicle.nil? || !vehicle.kind_of?(FipeApi::Vehicle)
      result = nil
      tables = self.all(vehicle)

      tables.each do |table|
        if table.month == month && table.year == year
          result = table
          break
        end
      end

      result
    end
  end
end
