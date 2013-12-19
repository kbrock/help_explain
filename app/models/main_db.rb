class MainDb < ActiveRecord::Base
  @table_name='schema_migrations'
  establish_connection :main

  def self.plan(sql)
    connection.execute("explain (analyze on, format json) #{sql}").first["QUERY PLAN"]
  end
end
