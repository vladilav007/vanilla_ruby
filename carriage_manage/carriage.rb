# frozen_string_literal: true

require_relative '../modules/railway_company'
require_relative '../modules/validation'

class Carriage
  include RailwayCompany
  include Validation

  validate :type, :format, option: /(passenger) | (cargo)/

  attr_accessor :type, :main_train

  #   because we never use the carriage in its usual form.
  #   PROTECTED

  protected

  def initialize(type)
    @type = type
    validate!
  end

  def add_train(train)
    self.main_train = train
  end

  # valid

  def validate!
    raise puts 'Train number cannot be empty' if type.nil?

    true
  end
end
