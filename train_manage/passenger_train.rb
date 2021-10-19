# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def add_passenger_carriage(carriage)
    @carriages.push carriage if !speed.positive? && carriage.type == :PassengerCarriage
  end
end
