# frozen_string_literal: true

require_relative 'train_manage/train'
require_relative 'train_manage/passenger_train'
require_relative 'train_manage/cargo_train'
require_relative 'route'
require_relative 'station'
require_relative 'carriage_manage/carriage'
require_relative 'carriage_manage/cargo_carriage'
require_relative 'carriage_manage/passenger_carriage'
require_relative 'modules/service_action'
require_relative 'modules/valid'
require_relative 'modules/validation'
require_relative 'modules/train_action'
require_relative 'modules/station_action'
require_relative 'modules/carriage_action'
require_relative 'modules/general_action'

class Main
  include GeneralAction
  include Validate
  include TrainAction
  include StationAction
  include CarriageAction
  include ServiceAction
  include Validation

  attr_accessor :stations, :trains

  ACTIONS = {
    1 => :station_controller,
    2 => :choose_train_type,
    3 => :check_train_carriage_list,
    4 => :check_train_delet_list,
    5 => :check_train_list,
    6 => :list_controller,
    7 => :take_seat_or_volume
  }.freeze

  def initialize
    @stations = []
    @trains = []
  end

  def text_ui
    loop do
      action = menu
      break if action.zero?

      send(ACTIONS[action])
    rescue StandardError
      puts 'Wrong input!'
    end
  end
end

controller = Main.new
puts '(0) for exit'
controller.text_ui
