# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def add_cargo_carriage(carriage)
    @carriages.push carriage if !speed.positive? && carriage.type == :CargoCarriage
  end
end
