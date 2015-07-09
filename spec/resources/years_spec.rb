require 'spec_helper'

describe FipeApi::Year do
  it 'should initialize properly' do
    v = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
    t = FipeApi::Table.new("1", 7, 2015)
    b = FipeApi::Brand.new("1", "Ford", t, v)
    m = FipeApi::Model.new("1", "Integra GS 1.8", b)
    y = FipeApi::Year.new("1992-1", "1992 Gasolina", m)
    expect(y.id).to eq "1992"
    expect(y.fuel).to eq "1"
    expect(y.name).to eq "1992 Gasolina"
    expect(y.model).to be_a FipeApi::Model
  end

  it 'should return a fipe result initialized for a specific year from a specific model from a specific brand from a vehicle and table' do
    v = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
    brands = v.get_brands
    expect(brands.length).not_to eq 0
    models = brands.first.get_models
    expect(models.length).not_to eq 0
    years = models.first.get_years
    expect(years.length).not_to eq 0
    fipe_result = years.first.get_result

    expect(fipe_result).to be_a FipeApi::FipeResult
    expect(fipe_result.id).not_to eq nil
    expect(fipe_result.authentication).not_to eq nil
    expect(fipe_result.year).to be_a FipeApi::Year
    expect(fipe_result.fuel).not_to eq nil
    expect(fipe_result.price).not_to eq nil
    expect(fipe_result.query_time).not_to eq nil
  end
end
