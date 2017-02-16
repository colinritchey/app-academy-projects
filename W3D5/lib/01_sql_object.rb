require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @columns ||= []

    if @columns.empty?
      entries = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{self.table_name}
      SQL
      @columns = entries.first.map{ |entry| entry.to_sym }
    else
      @columns
    end
  end

  def self.finalize!
    self.columns.each do |col|
      define_method "#{col}=" do |thing|
        self.attributes[col] = thing
      end

      define_method "#{col}" do
        self.attributes[col]
      end

    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.downcase.concat("s")
  end

  def self.all
    data = DBConnection.execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    self.parse_all(data)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      where
        id = #{id}
    SQL
    self.parse_all(result).first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = "#{attr_name}".to_sym

      unless self.class.columns.include?(attr_name)
        raise "unknown attribute '#{attr_name}'"
      end

      self.send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |attr_name|
      self.send("#{attr_name}")
    end
  end

  def insert
    question_marks = ['?'] * (attribute_values.length-1)
    string_q_marks = question_marks.join(', ')

    attribute_values_no_id = attribute_values[1..-1]
    column_names_str = self.class.columns[1..-1].join(', ')

    DBConnection.execute(<<-SQL, *attribute_values_no_id)
      insert into
        #{self.class.table_name} (#{column_names_str})
      values
        (#{string_q_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
    # p self
  end

  def update
    attribute_values_no_id = attribute_values[1..-1]

    set_string = self.class.columns[1..-1].map do |v|
      "#{v} = ?"
    end.join(', ')

    DBConnection.execute(<<-SQL, *attribute_values_no_id)
      update
        #{self.class.table_name}
      set
        #{set_string}
      where
        id = #{self.id}
    SQL

  end

  def save
    self.id.nil? ? insert : update
  end
end
