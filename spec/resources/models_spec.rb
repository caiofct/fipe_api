require 'spec_helper'

describe FipeApi::Model do
  it 'should initialize properly' do
    v = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
    t = FipeApi::Table.new("1", 7, 2015)
    b = FipeApi::Brand.new("1", "Ford", t, v)
    m = FipeApi::Model.new("1", "Integra GS 1.8", b)
    expect(m.id).to eq "1"
    expect(m.name).to eq "Integra GS 1.8"
    expect(m.brand).to be_a FipeApi::Brand
  end

  it 'should return all years initialized for a specific brand from a vehicle and table' do
    v = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
    brands = v.get_brands
    expect(brands.length).not_to eq 0
    models = brands.first.get_models
    expect(models.length).not_to eq 0
    years = models.first.get_years

    years.each do |y|
      expect(y).to be_a FipeApi::Year
      expect(y.id).not_to eq nil
      expect(y.name).not_to eq nil
      expect(y.model).to be_a FipeApi::Model
    end
  end
end
