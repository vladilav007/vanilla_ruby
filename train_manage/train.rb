# frozen_string_literal: true

require_relative '../modules/valid'
require_relative '../route'
require_relative '../modules/railway_company'

class Train
  include RailwayCompany
  include Validate

  attr_accessor :speed,
                :station_index,
                :route,
                :carriages,
                :number

  # initialize

  def initialize(number)
    @speed = 0
    @route = nil
    @station_index = 0
    @number = number
    @carriages = []
    validate!
  end

  #   because we never use the train in its usual form, the train must have a passenger or freight modification.
  #   To refer to the descendants of the class and that the parent class is closed for the user, use the access modifier
  #   PROTECTED

  protected

  def faster(value)
    if (value + @speed) > 250
      puts 'Too Fast! Not possible for this train!'
    elsif (value + @speed) <= 250 && (value + @speed).positive?
      @speed += value
      puts("The speed was increased by #{value}. Now train speed #{@speed}.")
    else puts('Input error!')
    end
  end

  def stop_train
    @speed = 0
    puts 'The train was stopped'
  end

  def show_speed
    puts "Speed of the train = #{@speed}"
  end

  # carriage settings
  public

  def delete_cariage(name)
    @carriages.delete_if { |t| t.type == name }
  end

  # route for train

  private

  #   Show that:
  #   Private methods work well if they are called in the file where they are located.
  #   Or they are called in other methods of the class

  def add_route(route)
    self.route = route
  end

  public

  def current_station
    route.stations[station_index]
  end

  def next_station
    route.stations[station_index + 1]
  end

  def previus_station
    route.stations[station_index - 1] if station_index >= 1
  end

  def move_to_next_station
    self.station_index += 1 if next_station
  end

  def carriages_in(&block)
    @carriages.each do |carriage|
      block.call(carriage)
    end
  end

  # valid

  def validate!
    raise puts 'Train number cannot be empty' if number.nil?
    if number !~ /^[a-z\d]{3}-?[a-z\d]{2}$/i
      raise puts 'Train number does not match format (Valid format: xxx-xx or xxxxx)'
    end

    true
  end
end
