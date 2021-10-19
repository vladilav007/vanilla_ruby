# frozen_string_literal: true

require_relative 'carriage'
require_relative '../constant'

class CargoCarriage < Carriage
  include Constant
  attr_accessor :capacity, :load

  def initialize(type)
    super(type)
    @capacity = WAGON_WOLUME
    @load = 0
  end

  def load_cargo(value)
    if value <= @capacity && value.positive?
      if (@load + value) > capacity
        puts 'Has not enough space for this value!'
        return
      end
      @load += value
      puts "You occupied the volume: #{value}, free left: #{@capacity - @load}"
    else
      puts 'Check your input information!'
    end
  end

  def occupied
    @load
  end

  def vacancies
    @capacity - @load
  end
end
