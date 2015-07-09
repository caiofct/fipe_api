require 'spec_helper'

describe FipeApi::Brand do
  it 'should initialize properly' do
    v = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
    t = FipeApi::Table.new("1", 7, 2015)
    b = FipeApi::Brand.new("1", "Ford", t, v)
    expect(b.id).to eq "1"
    expect(b.name).to eq "Ford"
    expect(b.table).to be_a FipeApi::Table
    expect(b.vehicle).to be_a FipeApi::Vehicle
  end

  it 'should return all models initialized for a specific brand from a vehicle and table' do
    v = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
    brands = v.get_brands
    expect(brands.length).not_to eq 0
    models = brands.first.get_models
    models.each do |m|
      expect(m).to be_a FipeApi::Model
      expect(m.id).not_to eq nil
      expect(m.name).not_to eq nil
      expect(m.brand).to be_a FipeApi::Brand
    end
  end
end
