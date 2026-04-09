class CreateKlubs < ActiveRecord::Migration[8.1]
  def change
    create_table :klubs do |t|
      t.string :name
      t.text :description
      t.string :activity_type

      t.timestamps
    end
  end
end
