class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :name, null: false
      t.text :comment
      t.text :sql, null: false
      t.text :plan, null: false
      t.timestamps
    end
  end
end
