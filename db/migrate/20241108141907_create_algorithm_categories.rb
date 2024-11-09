class CreateAlgorithmCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :algorithm_categories do |t|
      t.string :name
      t.string :slug
      t.text :descrtiption
      t.string :icon
      t.integer :display_order
      t.boolean :active

      t.timestamps
    end
    add_index :algorithm_categories, :name
    add_index :algorithm_categories, :slug
  end
end
