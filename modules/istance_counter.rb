# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :count_instances

    def instances
      puts @count_instances
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.count_instances ||= 0
      self.class.count_instances += 1
    end
  end
end
