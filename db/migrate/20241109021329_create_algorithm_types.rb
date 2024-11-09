class CreateAlgorithmTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :algorithm_types do |t|
      t.references :algorithm_category, null: false, foreign_key: true
      t.string :name, null: false
      t.string :slug
      t.text :description
      t.integer :display_order
      t.json :characteristics

      t.timestamps

       # Add unique index for slug
       t.index :slug, unique: true
       # Add unique composite index for algorithm_category_id and name
       t.index [:algorithm_category_id, :name], unique: true
    end
  end
end
