class CreateAlgorithmImplementations < ActiveRecord::Migration[7.0]
  def change
    create_table :algorithm_implementations do |t|
      t.references :algorithm, null: false, foreign_key: true
      t.string :language, null: false
      t.text :code, null: false
      t.text :explanation
      t.json :test_cases
      t.boolean :verified, default: false
      t.integer :votes_count, default: 0
      t.timestamps

      t.index [:algorithm_id, :language], unique: true
    end
  end
end
