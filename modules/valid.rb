# frozen_string_literal: true

module Validate
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    def valid?
      validate!
    rescue StandardError
      false
    end

    # train input
    def train_number_valid(number)
      raise 'Number is empty!' if number.empty?
      raise 'Form error' if number !~ /^[a-z\d]{3}-?[a-z\d]{2}$/i
    end

    def train_type_empty(type)
      raise 'Type is empty!' if type.empty?
    end

    def train_empty(trains)
      raise 'Empty!' if trains.empty?
    end
    # station input

    def station_number_valid(name)
      raise 'Name is empty!' if name.empty?
      raise 'Lenght2 error' if name.length < 3 || name.length > 16
    end

    # carriage input

    def carriage_number_valid(name)
      raise 'Name is empty!' if name.empty?
      raise 'Lenght2 error' if name.length < 3 || name.length > 10
    end
  end
end
