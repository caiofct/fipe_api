require 'spec_helper'

describe FipeApi::Table do
  it 'should initialize properly' do
    t = FipeApi::Table.new("1", 1, 2015)
    expect(t.id).to eq "1"
    expect(t.month).to eq 1
    expect(t.year).to eq 2015
  end

  it 'should get all tables for a specific vehicle' do
    v = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
    tables = FipeApi::Table.all(v)
    expect(tables.length).not_to eq 0
    tables.each do |t|
      expect(t).to be_a FipeApi::Table
      expect(t.id).not_to eq nil
      expect(t.month).not_to eq nil
      expect(t.year).not_to eq nil
    end
  end

  it 'should get the latest table for a specific vehicle' do
    v = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
    table = FipeApi::Table.latest(v)
    expect(table).to be_a FipeApi::Table
    expect(table.id).not_to eq nil
    expect(table.month).not_to eq nil
    expect(table.year).not_to eq nil
  end

  it 'should get a table for a certain month and year for a specific vehicle' do
    v = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
    table = FipeApi::Table.find_by_month_and_year(v, 1, 2015)
    expect(table).to be_a FipeApi::Table
    expect(table.id).not_to eq nil
    expect(table.month).to eq 1
    expect(table.year).to eq 2015
  end
end
