module ActiveModel
  class EachValidator
    # Performs validation on the supplied record. By default this will call
    # +validates_each+ to determine validity therefore subclasses should
    # override +validates_each+ with validation logic.
    #
    # This version checks that the attribute is present in order to validate it
    def validate(record)
      attributes.each do |attribute|
        if (record.class.partial_validation? ? record.attribute_present?(attribute.to_sym) : true)
          value = record.read_attribute_for_validation(attribute)
          next if (value.nil? && options[:allow_nil]) || (value.blank? && options[:allow_blank])
          validate_each(record, attribute, value)
        end
      end
    end
  end
end

module ActiveRecord
  module PartialValidation
    def self.included(base)
      base.module_eval do
        def self.using_partial_validations
          class_eval do
            def self.partial_validation?
              true
            end
          end
        end

        def self.partial_validation?
          false
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, ActiveRecord::PartialValidation
