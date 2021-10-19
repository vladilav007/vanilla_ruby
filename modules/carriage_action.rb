# frozen_string_literal: true

module CarriageAction
  def input_carriage_number
    puts 'Carriage number: '
    begin
      carriage_number = gets.chomp
      carriage_number_valid(carriage_number)
    rescue StandardError
      puts 'Check your input and try again'
      retry
    end
    carriage_number
  end

  def check_train_carriage_list
    begin
      train_empty(@trains)
    rescue StandardError
      puts 'Create one more trains firstly!'
      return
    end
    puts 'Choose a train to hit the wagon: '
    all_train_number
    add_carriage_controller
  end

  def add_carriage_controller
    train_number = input_train_number
    choose_train = choose_train_number(train_number)
    if choose_train.instance_of? PassengerTrain
      choose_carriage = input_carriage_number
      add_passenger_carriage(choose_train, choose_carriage)
    elsif choose_train.instance_of? CargoTrain
      choose_carriage = input_carriage_number
      add_cargo_carriage(choose_train, choose_carriage)
    else puts 'Carriage can not be added!'
    end
  end

  def add_passenger_carriage(choose_train, choose_carriage)
    choose_train.carriages << PassengerCarriage.new(choose_carriage)
    puts "Passenger carriage for train #{choose_train.number} was created!"
    puts 'List of the carriages on this train: '
    puts all_carriages(choose_train)
  end

  def add_cargo_carriage(choose_train, choose_carriage)
    choose_train.carriages << CargoCarriage.new(choose_carriage)
    puts "Cargo carriage for train #{choose_train.number} was created!"
    puts 'List of the carriages on this train: '
    puts all_carriages(choose_train)
  end

  def all_carriages(choose_train)
    choose_train.carriages.map(&:type).compact.join(' ')
  end

  def choose_carriage_number(carriage_number, choose_train)
    choose_train.carriages.find { |t| t.type == carriage_number }
  end

  def check_train_delet_list
    begin
      train_empty(@trains)
    rescue StandardError
      puts 'Create one more trains firstly!'
      return
    end
    puts 'Choose a train to delete the carriage: '
    all_train_number
    delet_train_carriage
  end

  def wagon_delete(choose_train)
    puts 'Choose a wagon for delete: '
    puts all_carriages(choose_train)
    choose_carriage = input_carriage_number
    choose_train.delete_cariage(choose_carriage)
    puts 'Carriage deleted! '
  end

  def delet_train_carriage
    train_number = input_train_number
    choose_train = choose_train_number(train_number)
    if (choose_train.instance_of? PassengerTrain) || (choose_train.instance_of? CargoTrain)
      if choose_train.carriages.map(&:type).compact.join(' ').length.positive?
        wagon_delete(choose_train)
      else puts 'No Carriages for delete!'
      end
    else puts 'Train not found!'
    end
  end
end
