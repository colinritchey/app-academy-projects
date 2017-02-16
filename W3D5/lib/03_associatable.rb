require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.to_s.constantize
  end

  def table_name
    self.class_name.downcase.concat('s')
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || name.capitalize
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] || "#{self_class_name.downcase}_id".to_sym
    @primary_key = options[:primary_key] || "id".to_sym
    @class_name = options[:class_name] || name.singularize.capitalize
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)

    define_method "#{name}" do
      params = {}
      params[options.primary_key] = self.send("#{options.foreign_key}")

      options.model_class.where(params).first

    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name.to_s, self.to_s, options)

    define_method "#{name}" do
      params = {}
      params[options.foreign_key] = self.send("#{options.primary_key}")

      options.model_class.where(params)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @a_options = {}
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
