class MainDb < ActiveRecord::Base
  @table_name='schema_migrations'
  establish_connection :main

  # would like to run these within a transaction
  # currently fetching plan while creating/updating Query and aborts transaction
  def self.plan(sql)
    #transaction do
      connection.execute("explain (analyze on, format json) #{sql}").first["QUERY PLAN"]
    #  raise ActiveRecord::Rollback
    #end
  end
end
