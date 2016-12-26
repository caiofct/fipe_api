require "http"
require "nokogiri"
require "fipe_api/utils"

module FipeApi
  class Base
    HEADERS = { "Referer" => "http://veiculos.fipe.org.br/", "Host" => "veiculos.fipe.org.br" }
  end
end
