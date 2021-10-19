# frozen_string_literal: true

require_relative 'modules/validation'
require_relative 'station'

class Route
  include Validation

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = []
    @stations << first_station
    @stations << last_station
    validate!
  end

  def add_base_station(start_station, finish_station)
    @stations.unshift(start_station)
    @stations << finish_station
  end

  def add_station(station_name)
    @stations.insert(1, *station_name)
  end

  def delete_station(station_number)
    @stations.delete_at(station_number)
  end

  def show_route
    puts @stations
  end
end
