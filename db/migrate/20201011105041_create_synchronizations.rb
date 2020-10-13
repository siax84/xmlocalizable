class CreateSynchronizations < ActiveRecord::Migration[6.0]
  def change
    create_table :synchronizations do |t|
      t.string :name
      t.string :source_platform
      t.text :source_document      
      t.string :target_platform
      t.text :target_document      

      t.timestamps
    end
  end
end
