require 'sqlite3'
require 'singleton'
require 'byebug'

class QuestionsDB < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class ModelBase
  TABLES = {
    'User' => 'users'
  }

  def initialize

  end

  def self.find_by_id(id)
    data = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{TABLES[self.to_s]}
      WHERE
        id = ?
    SQL
    self.new(data.first)
  end

  def self.all
    data = QuestionsDB.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{TABLES[self.to_s]}
    SQL
    data.map { |datum| self.new(datum)}
  end

  def variables_to_s
    result = ""
    instance_variables.each_with_index do |item, i|
      next if item.to_s == '@id'
      result += "#{item} = ?"
      result += ", " unless i == (instance_variables.size - 2)
    end
    result.gsub(/[@]/, "")
  end

  def get_values
    values = instance_variables.map do |i|
      eval(i.to_s)
    end
  end

  def create_strings
    instance_variables.map(&:to_s)[0..-2].join(", ").gsub(/[@]/, "")
  end

  def get_marks

  end

  def save
    @id ? update : create
  end

  def update

    QuestionsDB.instance.execute(<<-SQL, *get_values)
      UPDATE
        #{TABLES[self.class.to_s]}
      SET
        #{variables_to_s}
      WHERE
        id = ?
    SQL
  end

  def create
    value = get_values[0..-2]
    r = []
    value.length.times{ r << "?"}
    
    QuestionsDB.instance.execute(<<-SQL, *value)
      INSERT INTO
        #{TABLES[self.class.to_s]} (#{create_strings})
      VALUES
        (#{r.join(", ")})
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

end

class User < ModelBase
  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options)
    @fname = options['fname']
    @lname = options['lname']
    @id = options['id']
  end

end


f = User.new("fname" => "James", "lname" => "Franco")
