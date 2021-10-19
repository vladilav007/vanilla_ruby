# frozen_string_literal: true

module GeneralAction
  def menu
    puts %(Choose action:
                (1) Create STATION
                (2) Create TRAIN
                (3) Add carriage to train
                (4) Disconnect the carriages from the train
                (5) Place trains in a station
                (6) View a list of stations and a list of trains at a station
                (7) Take seat or space in a train.
                )
    gets.chomp.to_i
  end
end
