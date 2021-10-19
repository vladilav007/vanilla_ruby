# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}"

        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=") do |value|
          instance_variable_set(var_name, value)
          send("#{name}_history") << value
        end
        define_history_var(name)
      end
    end

    def define_history_var(name)
      var_name_history = "@#{name}_history"
      define_method("#{name}_history") do
        instance_variable_get(var_name_history) ||
          instance_variable_set(var_name_history, [])
      end
    end

    def strong_attr_acessor(name, type)
      name = "@#{name}"
      define_method(name) { instance_variable_get(name) }
      define_method("@#{name}=") do |value|
        raise TypeError unless value.is_a?(type)

        instance_variable_set(name, value) if value.is_a?(type)
      end
    end
  end
end
