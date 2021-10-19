# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attribute_name, validation_type, option: true)
      if validation_hash[attribute_name]
        add_validation(attribute_name, validation_type, option)
      else
        create_validation(attribute_name, validation_type, option)
      end
    end

    def validation_hash
      @validation_hash ||= {}
    end

    protected

    def validation_errors(type, attribute_name)
      case type
      when :presence
        "#{attribute_name} shouldn't be nil or ''"
      when :format
        "#{attribute_name} has invalid format"
      when :type
        "#{attribute_name} has invalid type"
      else
        'Unknown error'
      end
    end

    def validation_types
      %i[presence format type]
    end

    def add_validation(attribute_name, validation_type, option)
      validation_hash[attribute_name][validation_type] = {
        option: option,
        error_message: validation_errors(validation_type, attribute_name)
      }
    end

    def create_validation(attribute_name, validation_type, option)
      validation_hash[attribute_name] = {
        validation_type => {
          option: option,
          error_message: validation_errors(validation_type, attribute_name)
        }
      }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validation_hash.each do |attribute_name, type|
        type.each do |key, value|
          send("#{key}_validation", value[:error_message], attribute_name, option: value[:option])
        end
      end
      true
    end

    def presence_validation(error_message, attribute_name, option: true)
      raise ArgumentError, error_message if [nil, ''].include?(public_send(attribute_name))

      option
    end

    def format_validation(error_message, attribute_name, option: true)
      raise ArgumentError, error_message if public_send(attribute_name).to_s !~ option
    end

    def type_validation(error_message, _attribute_name, option)
      raise error_message unless public_send(attr_name).is_a? option
    end
  end
end
