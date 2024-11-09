after :shared do
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

  # Note: Merge Sort and Quick Sort are already defined in Sorting Algorithms category

  MATRIX_OPERATIONS_ALGORITHMS = [
    {
      name: "Strassen's Matrix Multiplication",
      description: 'Algorithm for efficient multiplication of matrices using seven recursive multiplications instead of eight',
      time_complexity_best: 'O(n^2.807)', # n: matrix dimension
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
      ],
      edge_cases: [
        'Non-square matrices',
        'Small matrices',
        'Sparse matrices'
      ]
    }
  ].freeze

  GEOMETRIC_PROBLEMS_ALGORITHMS = [
    {
      name: 'Closest Pair of Points',
      description: 'Algorithm to find the closest pair of points in a set of points in 2D space',
      time_complexity_best: 'O(n log n)', # n: number of points
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
      ],
      edge_cases: [
        'Collinear points',
        'Duplicate points',
        'All points equidistant'
      ]
    }
  ].freeze

  ARITHMETIC_OPERATIONS_ALGORITHMS = [
    {
      name: 'Karatsuba Algorithm',
      description: 'Fast multiplication algorithm that reduces the multiplication of two n-digit numbers to three multiplications of n/2-digit numbers',
      time_complexity_best: 'O(n^1.585)', # n: number of digits
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
      ],
      edge_cases: [
        'Single digit numbers',
        'Numbers of different lengths',
        'Zero padding required'
      ]
    }
  ].freeze

  # Seed algorithms
  ActiveRecord::Base.transaction do
    # Seed Matrix Operations Algorithms
    puts "\nSeeding Matrix Operations Algorithms..."
    MATRIX_OPERATIONS_ALGORITHMS.each do |algorithm_data|
      algorithm = matrix_operations.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
        algo.assign_attributes(algorithm_data)
      end

      algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
        complexity.best_case = algorithm_data[:time_complexity_best]
        complexity.average_case = algorithm_data[:time_complexity_average]
        complexity.worst_case = algorithm_data[:time_complexity_worst]
        complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
      end
      print "."
    end

    # Seed Geometric Problems Algorithms
    puts "\nSeeding Geometric Problems Algorithms..."
    GEOMETRIC_PROBLEMS_ALGORITHMS.each do |algorithm_data|
      algorithm = geometric_problems.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
        algo.assign_attributes(algorithm_data)
      end

      algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
        complexity.best_case = algorithm_data[:time_complexity_best]
        complexity.average_case = algorithm_data[:time_complexity_average]
        complexity.worst_case = algorithm_data[:time_complexity_worst]
        complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
      end
      print "."
    end

    # Seed Arithmetic Operations Algorithms
    puts "\nSeeding Arithmetic Operations Algorithms..."
    ARITHMETIC_OPERATIONS_ALGORITHMS.each do |algorithm_data|
      algorithm = arithmetic_operations.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
        algo.assign_attributes(algorithm_data)
      end

      algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
        complexity.best_case = algorithm_data[:time_complexity_best]
        complexity.average_case = algorithm_data[:time_complexity_average]
        complexity.worst_case = algorithm_data[:time_complexity_worst]
        complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
      end
      print "."
    end
  end

  puts "\nDivide and Conquer Algorithms seeding completed!"
  puts "Created/Updated:"
  puts "- #{matrix_operations.algorithms.count} Matrix Operations Algorithms"
  puts "- #{geometric_problems.algorithms.count} Geometric Problems Algorithms"
  puts "- #{arithmetic_operations.algorithms.count} Arithmetic Operations Algorithms"
  puts "Note: Merge Sort and Quick Sort are in Sorting Algorithms category"
end
