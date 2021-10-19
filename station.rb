# frozen_string_literal: true

require_relative 'route'
require_relative 'modules/istance_counter'
require_relative 'modules/validation'

class Station
  include Validation

  attr_accessor :name, :trains

  validate :name, :presence

  # Initialize
  def initialize(name)
    @trains = []
    @name = name
    validate!
  end

  # Create class method all

  def add_train(train)
    @trains << train unless @trains.include?(train)
  end

  # Only trains on the station
  def show_trains
    puts @trains
  end

  def exist(train)
    @trains.include? train
  end

  def delete_train(traine_number)
    @trains.delete(traine_number)
  end

  def each_train(&block)
    trains.each(&block)
  end
end
