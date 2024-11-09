after :shared do
  backtracking = AlgorithmCategory.find_or_create_by!(
    name: 'Backtracking Algorithms',
    description: 'Algorithms that solve problems by trying different solutions and undoing failed attempts'
  )

  # Create Algorithm Types
  puzzle_solving = backtracking.algorithm_types.find_or_create_by!(
    name: 'Puzzle Solving',
    description: 'Algorithms for solving puzzles and game problems'
  )

  graph_problems = backtracking.algorithm_types.find_or_create_by!(
    name: 'Graph Problems',
    description: 'Backtracking solutions for graph-related problems'
  )

  optimization_problems = backtracking.algorithm_types.find_or_create_by!(
    name: 'Optimization Problems',
    description: 'Backtracking approaches to optimization problems'
  )

  PUZZLE_SOLVING_ALGORITHMS = [
    {
      name: 'N-Queens Problem',
      description: 'Algorithm to place N chess queens on an N×N chessboard so that no queens threaten each other',
      time_complexity_best: 'O(n!)', # n: board size
      time_complexity_average: 'O(n!)',
      time_complexity_worst: 'O(n!)',
      space_complexity: 'O(n)',
      stable: true,
      in_place: true,
      recursive: true,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Chess programming',
        'Constraint satisfaction problems',
        'Resource allocation',
        'Circuit board testing'
      ],
      advantages: [
        'Complete solution space exploration',
        'Memory efficient',
        'Finds all possible solutions',
        'Early pruning of invalid paths'
      ],
      disadvantages: [
        'Exponential time complexity',
        'Not suitable for large N',
        'Performance depends on board size',
        'Complex implementation for optimizations'
      ],
      edge_cases: [
        'N = 1',
        'N = 2, 3 (no solutions)',
        'Large board sizes'
      ]
    },
    {
      name: 'Sudoku Solver',
      description: 'Algorithm to solve 9x9 Sudoku puzzles by trying different numbers and backtracking on conflicts',
      time_complexity_best: 'O(1)',  # When puzzle is already solved
      time_complexity_average: 'O(9^(n*n))',  # n: board dimension
      time_complexity_worst: 'O(9^(n*n))',
      space_complexity: 'O(n*n)',
      stable: true,
      in_place: true,
      recursive: true,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Sudoku puzzle solving',
        'Constraint satisfaction problems',
        'Number placement puzzles',
        'Logic puzzle solving'
      ],
      advantages: [
        'Guaranteed to find solution if exists',
        'Space efficient',
        'Can verify uniqueness',
        'Works for all valid puzzles'
      ],
      disadvantages: [
        'Exponential worst-case time',
        'Not efficient for very sparse puzzles',
        'Sequential nature limits parallelization',
        'Performance varies with initial state'
      ],
      edge_cases: [
        'Empty puzzle',
        'Multiple solutions',
        'Invalid puzzles',
        'Minimum clue puzzles'
      ]
    }
  ].freeze

  GRAPH_PROBLEMS_ALGORITHMS = [
    {
      name: 'Hamiltonian Path',
      description: 'Algorithm to find a path that visits each vertex exactly once in a graph',
      time_complexity_best: 'O(n!)', # n: number of vertices
      time_complexity_average: 'O(n!)',
      time_complexity_worst: 'O(n!)',
      space_complexity: 'O(n)',
      stable: true,
      in_place: true,
      recursive: true,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Route planning',
        'Circuit design',
        'Network traversal',
        'Game solving'
      ],
      advantages: [
        'Finds exact solution',
        'Can find all possible paths',
        'Suitable for small graphs',
        'Memory efficient'
      ],
      disadvantages: [
        'Exponential complexity',
        'Not practical for large graphs',
        'No polynomial solution known',
        'NP-complete problem'
      ],
      edge_cases: [
        'Empty graph',
        'Single vertex',
        'Complete graph',
        'Disconnected graph'
      ]
    },
    {
      name: 'Graph Coloring',
      description: 'Algorithm to color graph vertices such that no adjacent vertices share the same color',
      time_complexity_best: 'O(m^n)', # m: colors, n: vertices
      time_complexity_average: 'O(m^n)',
      time_complexity_worst: 'O(m^n)',
      space_complexity: 'O(n)',
      stable: true,
      in_place: true,
      recursive: true,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Map coloring',
        'Schedule planning',
        'Register allocation',
        'Frequency assignment'
      ],
      advantages: [
        'Finds minimum coloring possible',
        'Can verify coloring validity',
        'Handles arbitrary graphs',
        'Optimal solution guaranteed'
      ],
      disadvantages: [
        'Exponential time complexity',
        'Limited to small graphs',
        'NP-complete for optimization',
        'Performance depends on graph structure'
      ],
      edge_cases: [
        'Empty graph',
        'Complete graph',
        'Bipartite graph',
        'Cycle graphs'
      ]
    }
  ].freeze

  OPTIMIZATION_PROBLEMS_ALGORITHMS = [
    {
      name: 'Subset Sum',
      description: 'Algorithm to find a subset of numbers that sum to a given target',
      time_complexity_best: 'O(2^n)', # n: number of elements
      time_complexity_average: 'O(2^n)',
      time_complexity_worst: 'O(2^n)',
      space_complexity: 'O(n)',
      stable: true,
      in_place: true,
      recursive: true,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Financial planning',
        'Resource allocation',
        'Load balancing',
        'Portfolio optimization'
      ],
      advantages: [
        'Finds exact solution',
        'Can find all possible solutions',
        'Works with negative numbers',
        'Memory efficient'
      ],
      disadvantages: [
        'Exponential complexity',
        'Limited to small sets',
        'NP-complete problem',
        'Not suitable for large datasets'
      ],
      edge_cases: [
        'Empty set',
        'All negative numbers',
        'Target sum zero',
        'No solution exists'
      ]
    }
  ].freeze

  # Seed algorithms
  ActiveRecord::Base.transaction do
    # Seed Puzzle Solving Algorithms
    puts "\nSeeding Puzzle Solving Algorithms..."
    PUZZLE_SOLVING_ALGORITHMS.each do |algorithm_data|
      # Ensure that the parent (algorithm_type) is saved before creating algorithms
      puzzle_solving.save! unless puzzle_solving.persisted?  # Ensure the parent is saved

      algorithm = puzzle_solving.algorithms.find_or_initialize_by(name: algorithm_data[:name]) do |algo|
        algo.assign_attributes(algorithm_data)
      end

      # Save the algorithm and its complexities
      if algorithm.new_record?
        algorithm.save!
      end

      # Create complexities for the algorithm
      algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
        complexity.best_case = algorithm_data[:time_complexity_best]
        complexity.average_case = algorithm_data[:time_complexity_average]
        complexity.worst_case = algorithm_data[:time_complexity_worst]
        complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
      end

      print "."
    end

    # Seed Graph Problems Algorithms
    puts "\nSeeding Graph Problems Algorithms..."

    GRAPH_PROBLEMS_ALGORITHMS.each do |algorithm_data|
      # Ensure that the parent (AlgorithmType) is saved before creating algorithms
      graph_problems.save! unless graph_problems.persisted?  # Ensure the parent is saved

      algorithm = graph_problems.algorithms.find_or_initialize_by(name: algorithm_data[:name]) do |algo|
        algo.assign_attributes(algorithm_data)
      end

      # Save the algorithm if it's a new record
      if algorithm.new_record?
        algorithm.save!
      end

      # Create complexities for the algorithm
      algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
        complexity.best_case = algorithm_data[:time_complexity_best]
        complexity.average_case = algorithm_data[:time_complexity_average]
        complexity.worst_case = algorithm_data[:time_complexity_worst]
        complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
      end

      print "."
    end

    # Seed Optimization Problems Algorithms
    puts "\nSeeding Optimization Problems Algorithms..."
    OPTIMIZATION_PROBLEMS_ALGORITHMS.each do |algorithm_data|
      # Ensure that the parent (AlgorithmType) is saved before creating algorithms
      optimization_problems.save! unless optimization_problems.persisted?  # Ensure the parent is saved
      optimization_problems.generate_slug if optimization_problems.slug.blank?  # Ensure the slug is generated for the parent

      algorithm = optimization_problems.algorithms.find_or_initialize_by(name: algorithm_data[:name]) do |algo|
        algo.assign_attributes(algorithm_data)
      end

      # Save the algorithm if it's a new record
      if algorithm.new_record?
        algorithm.save!
      end

      # Create complexities for the algorithm
      algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
        complexity.best_case = algorithm_data[:time_complexity_best]
        complexity.average_case = algorithm_data[:time_complexity_average]
        complexity.worst_case = algorithm_data[:time_complexity_worst]
        complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
      end

      print "."
    end
  end
  puts "\nBacktracking Algorithms seeding completed!"
  puts "Created/Updated:"
  puts "- #{puzzle_solving.algorithms.count} Puzzle Solving Algorithms"
  puts "- #{graph_problems.algorithms.count} Graph Problems Algorithms"
  puts "- #{optimization_problems.algorithms.count} Optimization Problems Algorithms"
end
