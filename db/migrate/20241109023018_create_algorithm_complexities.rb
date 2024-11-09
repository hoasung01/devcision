class CreateAlgorithmComplexities < ActiveRecord::Migration[7.0]
  def change
    create_table :algorithm_complexities do |t|
      t.references :algorithm, null: false, foreign_key: true
      t.string :operation_type # e.g., search, insert, delete
      t.string :best_case
      t.string :average_case
      t.string :worst_case
      t.text :explanation
      t.timestamps

      t.index [:algorithm_id, :operation_type], unique: true
    end
  end
end
