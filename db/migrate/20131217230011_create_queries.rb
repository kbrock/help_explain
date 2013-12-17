class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :name
      t.string :comment
      t.string :sql
      t.string :plan

      t.timestamps
    end
  end
end
