after :shared do
  numerical = AlgorithmCategory.find_or_create_by!(
    name: 'Numerical Algorithms',
    description: 'Algorithms for numerical computations and mathematical operations'
  )

  basic_math = numerical.algorithm_types.find_or_create_by!(
    name: 'Basic Mathematical Operations',
    description: 'Fundamental numerical computation algorithms'
  )

  advanced_math = numerical.algorithm_types.find_or_create_by!(
    name: 'Advanced Mathematical Operations',
    description: 'Complex numerical algorithms for advanced computations'
  )

  matrix_operations = numerical.algorithm_types.find_or_create_by!(
    name: 'Matrix Operations',
    description: 'Algorithms for matrix computations and transformations'
  )

  BASIC_MATH_ALGORITHMS = [
    {
      name: 'GCD and LCM',
      description: 'Algorithms to compute Greatest Common Divisor and Least Common Multiple',
      time_complexity_best: 'O(log min(a,b))', # a, b: input numbers
      time_complexity_average: 'O(log min(a,b))',
      time_complexity_worst: 'O(log min(a,b))',
      space_complexity: 'O(1)',
      stable: true,
      in_place: true,
      recursive: true,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner],
      use_cases: [
        'Fraction simplification',
        'Cryptography',
        'Number theory',
        'Key generation'
      ],
      advantages: [
        'Efficient logarithmic time',
        'Simple implementation',
        'Works with large numbers',
        'Memory efficient'
      ],
      disadvantages: [
        'Integer overflow possible',
        'Limited to integers',
        'Recursive stack usage',
        'Not suitable for floating point'
      ],
      edge_cases: [
        'Zero input',
        'Negative numbers',
        'Very large numbers',
        'Equal numbers'
      ]
    },
    {
      name: 'Prime Number Tests',
      description: 'Algorithms to test primality of numbers',
      time_complexity_best: 'O(√n)', # n: number to test
      time_complexity_average: 'O(√n)',
      time_complexity_worst: 'O(√n)',
      space_complexity: 'O(1)',
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Cryptography',
        'Number theory',
        'Hash functions',
        'Key generation'
      ],
      advantages: [
        'Simple implementation',
        'Deterministic result',
        'Memory efficient',
        'Parallelizable'
      ],
      disadvantages: [
        'Slow for large numbers',
        'Not practical for very large numbers',
        'Limited optimization potential',
        'CPU intensive'
      ],
      edge_cases: [
        'Numbers less than 2',
        'Perfect squares',
        'Carmichael numbers',
        'Very large numbers'
      ]
    }
  ].freeze

  ADVANCED_MATH_ALGORITHMS = [
    {
      name: 'Fast Fourier Transform',
      description: 'Algorithm for computing the Discrete Fourier Transform of a sequence',
      time_complexity_best: 'O(n log n)', # n: sequence length
      time_complexity_average: 'O(n log n)',
      time_complexity_worst: 'O(n log n)',
      space_complexity: 'O(n)',
      stable: true,
      in_place: false,
      recursive: true,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Signal processing',
        'Data compression',
        'Polynomial multiplication',
        'Frequency analysis'
      ],
      advantages: [
        'Efficient for large datasets',
        'Widely applicable',
        'Parallelizable',
        'Standard in signal processing'
      ],
      disadvantages: [
        'Complex implementation',
        'Memory intensive',
        'Numerical precision issues',
        'Power of 2 length preferred'
      ],
      edge_cases: [
        'Non-power-of-2 length',
        'All zero input',
        'Single value input',
        'Very large sequences'
      ]
    },
    {
      name: "Newton's Method",
      description: 'Iterative method for finding roots of functions',
      time_complexity_best: 'O(log n)', # n: precision digits
      time_complexity_average: 'O(log n)',
      time_complexity_worst: 'O(n)', # when convergence is slow
      space_complexity: 'O(1)',
      stable: false,
      in_place: true,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Root finding',
        'Optimization',
        'Solving equations',
        'Numerical approximation'
      ],
      advantages: [
        'Quadratic convergence',
        'Simple implementation',
        'Memory efficient',
        'High precision possible'
      ],
      disadvantages: [
        'Requires good initial guess',
        'May not converge',
        'Derivative required',
        'Local convergence only'
      ],
      edge_cases: [
        'Multiple roots',
        'No real roots',
        'Horizontal tangent points',
        'Poor initial guess'
      ]
    }
  ].freeze

  MATRIX_OPERATIONS_ALGORITHMS = [
    {
      name: 'Matrix Operations',
      description: 'Basic and advanced matrix manipulation algorithms',
      time_complexity_best: 'O(n²)', # n: matrix dimension
      time_complexity_average: 'O(n²)',
      time_complexity_worst: 'O(n³)',
      space_complexity: 'O(n²)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Linear algebra',
        'Computer graphics',
        'Scientific computing',
        '3D transformations'
      ],
      advantages: [
        'Fundamental operations',
        'Highly parallelizable',
        'Well-studied algorithms',
        'Wide applicability'
      ],
      disadvantages: [
        'High complexity for large matrices',
        'Memory intensive',
        'Numerical stability issues',
        'Cache performance critical'
      ],
      edge_cases: [
        'Singular matrices',
        'Identity matrices',
        'Sparse matrices',
        'Non-square matrices'
      ]
    }
  ].freeze

  # Seed algorithms
  ActiveRecord::Base.transaction do
    # Seed Basic Math Algorithms
    puts "\nSeeding Basic Math Algorithms..."
    BASIC_MATH_ALGORITHMS.each do |algorithm_data|
      algorithm = basic_math.algorithms.find_or_initialize_by(name: algorithm_data[:name])
      algorithm.assign_attributes(algorithm_data)
      algorithm.save!

      algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
        complexity.best_case = algorithm_data[:time_complexity_best]
        complexity.average_case = algorithm_data[:time_complexity_average]
        complexity.worst_case = algorithm_data[:time_complexity_worst]
        complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
      end
      print "."
    end

    # Seed Advanced Math Algorithms
    puts "\nSeeding Advanced Math Algorithms..."
    ADVANCED_MATH_ALGORITHMS.each do |algorithm_data|
      algorithm = advanced_math.algorithms.find_or_initialize_by(name: algorithm_data[:name])
      algorithm.assign_attributes(algorithm_data)
      algorithm.save!

      algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
        complexity.best_case = algorithm_data[:time_complexity_best]
        complexity.average_case = algorithm_data[:time_complexity_average]
        complexity.worst_case = algorithm_data[:time_complexity_worst]
        complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
      end
      print "."
    end

    # Seed Matrix Operations Algorithms
    puts "\nSeeding Matrix Operations Algorithms..."
    MATRIX_OPERATIONS_ALGORITHMS.each do |algorithm_data|
      algorithm = matrix_operations.algorithms.find_or_initialize_by(name: algorithm_data[:name])
      algorithm.assign_attributes(algorithm_data)
      algorithm.save!

      algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
        complexity.best_case = algorithm_data[:time_complexity_best]
        complexity.average_case = algorithm_data[:time_complexity_average]
        complexity.worst_case = algorithm_data[:time_complexity_worst]
        complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
      end
      print "."
    end
  end

  puts "\nNumerical Algorithms seeding completed!"
  puts "Created/Updated:"
  puts "- #{basic_math.algorithms.count} Basic Math Algorithms"
  puts "- #{advanced_math.algorithms.count} Advanced Math Algorithms"
  puts "- #{matrix_operations.algorithms.count} Matrix Operations"
end
