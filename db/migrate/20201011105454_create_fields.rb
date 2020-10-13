class CreateFields < ActiveRecord::Migration[6.0]
  def change
    create_table :fields do |t|
      t.references :synchronization, null: false, foreign_key: true
      t.string :name
      t.string :platform
      t.integer :line
      t.boolean :is_comment
      t.string :field_value

      t.timestamps
    end
  end
end
