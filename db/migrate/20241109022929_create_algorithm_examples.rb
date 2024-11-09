class CreateAlgorithmExamples < ActiveRecord::Migration[7.0]
  def change
    create_table :algorithm_examples do |t|
      t.references :algorithm, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.text :input_data
      t.text :output_data
      t.text :explanation
      t.integer :difficulty_level
      t.timestamps
    end
  end
end
