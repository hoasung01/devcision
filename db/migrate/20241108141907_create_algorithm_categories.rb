class CreateAlgorithmCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :algorithm_categories do |t|
      t.string :name, null: false
      t.string :slug
      t.text :descrtiption
      t.string :icon
      t.integer :display_order
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :algorithm_categories, :name
    add_index :algorithm_categories, :slug
  end
end