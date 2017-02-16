require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_string = params.map do |key, value|
      where_line(key)
    end.join(" and ")

    result = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      where
        #{where_string}
    SQL

    self.parse_all(result)
  end

  def where_line(key)
    "#{key} = ?"
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
