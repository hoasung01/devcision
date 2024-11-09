class CreateAlgorithmBenchmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :algorithm_benchmarks do |t|
      t.references :algorithm_implementation, null: false, foreign_key: true
      t.integer :input_size
      t.string :input_type # random, sorted, reverse_sorted, etc.
      t.decimal :execution_time
      t.decimal :memory_usage
      t.json :metrics # Additional performance metrics
      t.timestamps

      t.index [:algorithm_implementation_id, :input_size, :input_type],
              unique: true,
              name: 'index_algorithm_benchmarks_on_impl_size_and_type'
    end
  end
end
