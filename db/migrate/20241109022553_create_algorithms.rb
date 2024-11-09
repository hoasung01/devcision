class CreateAlgorithms < ActiveRecord::Migration[7.1]
  def change
    create_table :algorithms do |t|
      t.references :algorithm_type, null: false, foreign_key: true
      t.string :name, null: false
      t.string :slug
      t.text :description
      t.text :prerequisites

      # Complexity characteristics
      t.string :time_complexity_best
      t.string :time_complexity_average
      t.string :time_complexity_worst
      t.string :space_complexity

      # Algorithm properties
      t.boolean :stable
      t.boolean :in_place
      t.boolean :recursive
      t.boolean :parallel_possible
      t.integer :difficulty_level

      # Additional metadata
      t.json :use_cases
      t.json :advantages
      t.json :disadvantages
      t.json :edge_cases

      t.timestamps

      t.index :slug, unique: true
      t.index [:algorithm_type_id, :name], unique: true
    end
  end
end
