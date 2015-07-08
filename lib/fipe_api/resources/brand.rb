module FipeApi
  class Brand < FipeApi::Base
    attr_accessor :id
    attr_accessor :name

    def initialize(id, name)
      self.id = id
      self.name = name
    end
  end
end