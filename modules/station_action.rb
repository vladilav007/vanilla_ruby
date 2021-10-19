# frozen_string_literal: true

module StationAction
  def station_controller
    if @stations.empty?
      puts 'You must to have first and last station!'
      start = input_station_name
      finish = input_station_name
      create_initial_stations(start, finish)
    else
      create_new_station
    end
  end

  def create_initial_stations(first, last)
    @stations << Station.new(first)
    @stations << Station.new(last)
    @route = Route.new(first, last)
    puts 'Initial stations were created!'
  end

  def input_station_name
    puts 'Station name: '
    begin
      station = gets.chomp
      station_number_valid(station)
    rescue StandardError
      puts 'Check your input and try again'
      retry
    end
    station
  end

  def create_new_station
    station_name = input_station_name
    if @stations.find { |s| s.name == station_name }
      puts 'Station exist!'
      return
    end
    @stations << Station.new(station_name)
    @route.add_station(station_name)
    puts "Station #{station_name} was created!"
  end

  def all_station_number
    puts @stations.map(&:name).compact.join(' ')
  end

  def choose_station_number(station_number)
    @stations.find { |t| t.name == station_number }
  end

  def list_controller
    puts 'Select a station to view train availability: '
    if @stations.size.positive?
      all_station_number
      station_number = input_station_name
      choose_station = choose_station_number(station_number)
      choose_station.trains.map do |t|
        puts "№ #{t.number},Type: #{t.class}, Car.:#{t.carriages.length}"
      end.compact.join(' ')
    else puts 'Stations - 0'
    end
  end
end
