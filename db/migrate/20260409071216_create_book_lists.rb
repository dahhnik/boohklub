class CreateBookLists < ActiveRecord::Migration[8.1]
  def change
    create_table :book_lists do |t|
      t.references :klub, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :month
      t.integer :year

      t.timestamps
    end
    add_index :book_lists, [ :klub_id, :month, :year ], unique: true
  end
end
