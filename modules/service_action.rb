# frozen_string_literal: true

module ServiceAction
  def take_seat_or_volume
    return if @trains.empty?

    all_train_number
    train_number = input_train_number
    choose_train = choose_train_number(train_number)
    return if (!choose_train.instance_of? PassengerTrain) && (!choose_train.instance_of? CargoTrain)

    puts all_carriages(choose_train)
    return if choose_train.carriages.empty?

    carriage_number = input_carriage_number
    choose_carriage = choose_carriage_number(carriage_number, choose_train)
    service_carriage_controller(choose_carriage)
  end

  def service_carriage_controller(choose_carriage)
    passenger_service(choose_carriage) if choose_carriage.instance_of? PassengerCarriage
    cargo_service(choose_carriage) if choose_carriage.instance_of? CargoCarriage

    nil
  end

  def passenger_carriage_status(choose_carriage)
    puts "Carriage has #{choose_carriage.vacancies} of #{choose_carriage.capacity} seats"
  end

  def cargo_carriage_status(choose_carriage)
    puts "Carriage has #{choose_carriage.vacancies} of #{choose_carriage.capacity} space"
  end

  def cargo_service(choose_carriage)
    cargo_carriage_status(choose_carriage)
    puts 'How much space do you need: '
    check = gets.chomp.to_i
    if check.positive?
      choose_carriage.load_cargo(check)
      cargo_carriage_status(choose_carriage)
    end
    nil
  end

  def passenger_service(choose_carriage)
    passenger_carriage_status(choose_carriage)
    puts 'Do you want take place in a train? (+) (-)'
    check = gets.chomp
    choose_carriage.load_passenger if check == '+'
    nil
  end
end
