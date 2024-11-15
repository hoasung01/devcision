class CreateUnitTables < ActiveRecord::Migration[7.1]
 def change
   create_table :unit_categories do |t|
     t.string :name, null: false
     t.string :slug
     t.text :description
     t.string :icon
     t.integer :display_order
     t.boolean :active, default: true

     t.timestamps
     t.index :slug, unique: true
   end

   create_table :units do |t|
     t.references :unit_category, null: false, foreign_key: true
     t.string :name, null: false
     t.string :symbol
     t.decimal :base_value
     t.string :base_unit
     t.text :description
     t.integer :display_order

     t.timestamps
     t.index [:unit_category_id, :symbol], unique: true
   end

   create_table :unit_comparisons do |t|
     t.references :unit, null: false, foreign_key: true
     t.string :title, null: false
     t.text :description
     t.decimal :value
     t.string :comparison_type
     t.json :metadata
     t.integer :difficulty_level

     t.timestamps
     t.index [:unit_id, :value]
   end

   create_table :unit_conversions do |t|
     t.references :from_unit, null: false, foreign_key: { to_table: :units }
     t.references :to_unit, null: false, foreign_key: { to_table: :units }
     t.decimal :conversion_factor, null: false
     t.text :explanation

     t.timestamps
     t.index [:from_unit_id, :to_unit_id], unique: true
   end
 end
end
