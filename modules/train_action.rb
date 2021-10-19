# frozen_string_literal: true

module TrainAction
  def choose_train_type
    puts %(Enter type of the train:
      (1) passenger,(2) cargo)
    train_type = gets.chomp
    type_controller(train_type)
  end

  def type_controller(train_type)
    case train_type
    when '1'
      train_number = input_train_number
      create_passenger_train(train_number)
    when '2'
      train_number = input_train_number
      create_cargo_train(train_number)
    else
      puts 'Type does not exist'
    end
  end

  def input_train_number
    puts 'Enter number/name of the train: XXXXX'
    begin
      train_number = gets.chomp
      train_number_valid(train_number)
    rescue StandardError
      puts 'Check your input and try again'
      retry
    end
    train_number
  end

  def create_passenger_train(train_number)
    @trains << PassengerTrain.new(train_number)
    puts "Passenger train #{train_number} was created!"
  end

  def create_cargo_train(train_number)
    @trains << CargoTrain.new(train_number)
    puts "Cargo train #{train_number} was created!"
  end

  def check_train_list
    begin
      train_empty(@trains)
    rescue StandardError
      puts 'Create one more trains firstly!'
      return
    end
    puts 'Choose a train to place a station: '
    return if @stations.empty?

    all_train_number
    add_train_controller
  end

  def add_train_controller
    train_number = input_train_number
    choose_train = choose_train_number(train_number)
    return if (!choose_train.instance_of? PassengerTrain) && (!choose_train.instance_of? CargoTrain)

    puts "Choose a station for train #{choose_train.number} : "
    all_station_number
    station_number = input_station_name
    choose_station = choose_station_number(station_number)
    exist_on_station(choose_train)
    add_train_to_station(choose_train, choose_station)
  end

  def all_train_number
    puts @trains.map(&:number).compact.join(' ')
  end

  def choose_train_number(train_number)
    @trains.find { |t| t.number == train_number }
  end

  def exist_on_station(choose_train)
    @stations.each do |s|
      s.trains.each do |t|
        if t.number == choose_train.number
          s.delete_train(t)
          puts "Removed information on the previous location of the train #{t.number} "
        end
      end
    end
  end

  def add_train_to_station(choose_train, choose_station)
    if (choose_train.instance_of? PassengerTrain) || (choose_train.instance_of? CargoTrain)
      if choose_station.instance_of? Station
        choose_station.add_train(choose_train)
        puts "Train #{choose_train.number}, was added to the station #{choose_station.name}"
      end
    else
      puts 'Train or Station not found!'
      nil
    end
  end
end
