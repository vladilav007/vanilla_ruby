# frozen_string_literal: true

require_relative 'carriage'
require_relative '../constant'

class PassengerCarriage < Carriage
  include Constant

  attr_accessor :capacity, :load

  def initialize(type)
    super(type)
    @capacity = SEATS
    @load = 0
  end

  def load_passenger
    if @load < @capacity
      @load += 1
      puts "You have taken one seat, free left: #{@capacity - @load}"
    else
      puts 'There are no more places'
    end
  end

  def occupied
    @load
  end

  def vacancies
    @capacity - @load
  end
end
