class CreateMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :mappings do |t|
      t.references :source_field, null: false, foreign_key: {to_table: :fields, column: :id }
      t.references :target_field, null: true, foreign_key: {to_table: :fields, column: :id }
      t.boolean :bidirectional
      t.references :synchronization, null: false, foreign_key: true
      t.string :common_value

      t.timestamps
    end
  end
end
