# db/seeds/algorithms/07_divide_conquer.seeds.rb
after :shared do
  def find_or_create_algorithm(type, algorithm_data)
    algorithm = type.algorithms.find_or_initialize_by(name: algorithm_data[:name])

    # Only update attributes if it's a new record
    if algorithm.new_record?
      algorithm.assign_attributes(algorithm_data.except(:name))
      algorithm.save!
    end

    # Always ensure complexity exists
    algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
      complexity.best_case = algorithm_data[:time_complexity_best]
      complexity.average_case = algorithm_data[:time_complexity_average]
      complexity.worst_case = algorithm_data[:time_complexity_worst]
      complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
    end

    algorithm
  end

  # Create category
  divide_conquer = AlgorithmCategory.find_or_create_by!(
    name: 'Divide and Conquer Algorithms',
    description: 'Algorithms that break down problems into smaller subproblems, solve them, and combine the solutions'
  )

  # Create Algorithm Types
  matrix_operations = divide_conquer.algorithm_types.find_or_create_by!(
    name: 'Matrix Operations',
    description: 'Divide and conquer algorithms for matrix computations'
  )

  geometric_problems = divide_conquer.algorithm_types.find_or_create_by!(
    name: 'Geometric Problems',
    description: 'Algorithms solving geometric problems using divide and conquer'
  )

  arithmetic_operations = divide_conquer.algorithm_types.find_or_create_by!(
    name: 'Arithmetic Operations',
    description: 'Fast arithmetic computation algorithms using divide and conquer'
  )

  MATRIX_OPERATIONS_ALGORITHMS = [
    {
      name: "Strassen's Matrix Multiplication",
      description: 'Algorithm for efficient multiplication of matrices using seven recursive multiplications instead of eight',
      time_complexity_best: 'O(n^2.807)',
      time_complexity_average: 'O(n^2.807)',
      time_complexity_worst: 'O(n^2.807)',
      space_complexity: 'O(n^2)',
      stable: true,
      in_place: false,
      recursive: true,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Large matrix multiplication',
        'Scientific computing',
        'Computer graphics',
        'Signal processing'
      ],
      advantages: [
        'Better than naive O(n³) multiplication',
        'Significant for very large matrices',
        'Theoretical importance',
        'Parallelizable'
      ],
      disadvantages: [
        'Complex implementation',
        'High constant factors',
        'Numerical stability issues',
        'Memory intensive'
      ]
    }
  ].freeze

  GEOMETRIC_PROBLEMS_ALGORITHMS = [
    {
      name: 'Closest Pair of Points',
      description: 'Algorithm to find the closest pair of points in a set of points in 2D space',
      time_complexity_best: 'O(n log n)',
      time_complexity_average: 'O(n log n)',
      time_complexity_worst: 'O(n log n)',
      space_complexity: 'O(n)',
      stable: true,
      in_place: false,
      recursive: true,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Computational geometry',
        'Geographic information systems',
        'Collision detection',
        'Cluster analysis'
      ],
      advantages: [
        'Efficient for large datasets',
        'Better than brute force O(n²)',
        'Can be extended to k dimensions',
        'Handles dynamic updates'
      ],
      disadvantages: [
        'Complex implementation',
        'Memory overhead',
        'Requires sorted points',
        'Coordinate system dependent'
      ]
    }
  ].freeze

  ARITHMETIC_OPERATIONS_ALGORITHMS = [
    {
      name: 'Karatsuba Algorithm',
      description: 'Fast multiplication algorithm for large numbers',
      time_complexity_best: 'O(n^1.585)',
      time_complexity_average: 'O(n^1.585)',
      time_complexity_worst: 'O(n^1.585)',
      space_complexity: 'O(n)',
      stable: true,
      in_place: false,
      recursive: true,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Large integer multiplication',
        'Cryptography',
        'Numerical computation',
        'Big number libraries'
      ],
      advantages: [
        'Faster than standard multiplication',
        'Important for large numbers',
        'Base of modern multiplication',
        'Reduced recursive calls'
      ],
      disadvantages: [
        'Complex implementation',
        'Overhead for small numbers',
        'Memory recursive overhead',
        'Base dependent'
      ]
    }
  ].freeze

  # Seed algorithms
  ActiveRecord::Base.transaction do
    begin
      # Seed Matrix Operations Algorithms
      puts "\nSeeding Matrix Operations Algorithms..."
      MATRIX_OPERATIONS_ALGORITHMS.each do |algorithm_data|
        find_or_create_algorithm(matrix_operations, algorithm_data)
        print "."
      end

      # Seed Geometric Problems Algorithms
      puts "\nSeeding Geometric Problems Algorithms..."
      GEOMETRIC_PROBLEMS_ALGORITHMS.each do |algorithm_data|
        find_or_create_algorithm(geometric_problems, algorithm_data)
        print "."
      end

      # Seed Arithmetic Operations Algorithms
      puts "\nSeeding Arithmetic Operations Algorithms..."
      ARITHMETIC_OPERATIONS_ALGORITHMS.each do |algorithm_data|
        find_or_create_algorithm(arithmetic_operations, algorithm_data)
        print "."
      end

      puts "\nDivide and Conquer Algorithms seeding completed!"
      puts "Created/Updated:"
      puts "- #{matrix_operations.algorithms.count} Matrix Operations Algorithms"
      puts "- #{geometric_problems.algorithms.count} Geometric Problems Algorithms"
      puts "- #{arithmetic_operations.algorithms.count} Arithmetic Operations Algorithms"
    rescue ActiveRecord::RecordInvalid => e
      puts "\nError during seeding: #{e.message}"
      puts "Record that failed: #{e.record.inspect}"
      raise e
    end
  end
end
