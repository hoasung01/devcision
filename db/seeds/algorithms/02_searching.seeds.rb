after :shared do
  searching = AlgorithmCategory.find_or_create_by!(
    name: 'Searching Algorithms',
    description: 'Algorithms designed to find elements within data structures and graphs'
  )

  # Create Algorithm Types
  comparison_searching = searching.algorithm_types.find_or_create_by!(
    name: 'Comparison Based Searching',
    description: 'Algorithms that search by comparing elements'
  )

  graph_searching = searching.algorithm_types.find_or_create_by!(
    name: 'Graph Based Searching',
    description: 'Algorithms for searching in graph structures'
  )

  heuristic_searching = searching.algorithm_types.find_or_create_by!(
    name: 'Heuristic Based Searching',
    description: 'Advanced searching algorithms using heuristics'
  )

  # Define Algorithms
  COMPARISON_SEARCHING_ALGORITHMS = [
    {
      name: 'Linear Search',
      description: 'Simple sequential search algorithm',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:constant],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:linear],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner],
      use_cases: [
        'Small datasets',
        'Unsorted arrays',
        'Finding multiple occurrences'
      ],
      advantages: [
        'Simple implementation',
        'Works on unsorted arrays',
        'No extra space needed'
      ],
      disadvantages: [
        'Slow for large datasets',
        'Not efficient for sorted arrays'
      ],
      edge_cases: [
        'Empty arrays',
        'Single element arrays',
        'Element not present'
      ]
    },
    {
      name: 'Binary Search',
      description: 'Efficient search algorithm for sorted arrays',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:constant],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: true,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner],
      use_cases: [
        'Sorted arrays',
        'Large datasets',
        'Dictionary lookups'
      ],
      advantages: [
        'Very efficient for sorted arrays',
        'Logarithmic time complexity',
        'Predictable performance'
      ],
      disadvantages: [
        'Requires sorted array',
        'Only works with random access',
        'Not suitable for small arrays'
      ],
      edge_cases: [
        'Empty array',
        'Single element',
        'Duplicate elements',
        'Element not present'
      ]
    },
    {
      name: 'Jump Search',
      description: 'Block-jumping search algorithm for sorted arrays',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:constant],
      time_complexity_average: 'O(√n)',
      time_complexity_worst: 'O(√n)',
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Sorted arrays',
        'When binary search is too complex',
        'Medium-sized datasets'
      ],
      advantages: [
        'Better than linear search',
        'Simpler than binary search',
        'Good for skipping elements'
      ],
      disadvantages: [
        'Requires sorted array',
        'Fixed step size limitation',
        'Not as efficient as binary search'
      ],
      edge_cases: [
        'Step size calculation',
        'Array bounds checking',
        'Last block handling'
      ]
    },
    {
      name: 'Interpolation Search',
      description: 'Improved binary search using value interpolation',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:constant],
      time_complexity_average: 'O(log log n)',
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:linear],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: true,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Sorted arrays',
        'Uniform element distribution',
        'Large datasets'
      ],
      advantages: [
        'Better than binary search for uniform distribution',
        'Good average case',
        'Works well with large datasets'
      ],
      disadvantages: [
        'Complex implementation',
        'Poor worst case',
        'Requires uniform distribution'
      ],
      edge_cases: [
        'Non-uniform distribution',
        'Duplicate elements',
        'Extreme values'
      ]
    }
  ].freeze

  GRAPH_SEARCHING_ALGORITHMS = [
    {
      name: 'Depth First Search',
      description: 'Graph traversal using depth-first strategy',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: 'O(V + E)',
      time_complexity_worst: 'O(V + E)',
      space_complexity: 'O(V)',
      stable: true,
      in_place: false,
      recursive: true,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Topological sorting',
        'Cycle detection',
        'Path finding',
        'Maze solving'
      ],
      advantages: [
        'Memory efficient for deep graphs',
        'Naturally recursive',
        'Good for deep exploration'
      ],
      disadvantages: [
        'Can get stuck in deep paths',
        'Stack overflow risk',
        'Not optimal for shortest paths'
      ],
      edge_cases: [
        'Disconnected graphs',
        'Cycles',
        'Single node graph'
      ]
    },
    {
      name: 'Breadth First Search',
      description: 'Graph traversal using breadth-first strategy',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: 'O(V + E)',
      time_complexity_worst: 'O(V + E)',
      space_complexity: 'O(V)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Shortest path in unweighted graphs',
        'Level-order traversal',
        'Finding connected components'
      ],
      advantages: [
        'Finds shortest path',
        'Level by level exploration',
        'Good for social networks'
      ],
      disadvantages: [
        'More memory intensive',
        'Not suitable for deep graphs',
        'Queue management overhead'
      ],
      edge_cases: [
        'Disconnected graphs',
        'Single node',
        'Complete graphs'
      ]
    }
  ].freeze

  HEURISTIC_SEARCHING_ALGORITHMS = [
    {
      name: 'A* Search',
      description: 'Heuristic search algorithm for finding optimal paths',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: 'O(b^d)',
      time_complexity_worst: 'O(b^d)',
      space_complexity: 'O(b^d)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Pathfinding in games',
        'Robot navigation',
        'GPS routing'
      ],
      advantages: [
        'Optimal path finding',
        'Uses domain knowledge',
        'Complete algorithm'
      ],
      disadvantages: [
        'Memory intensive',
        'Requires good heuristic',
        'Complex implementation'
      ],
      edge_cases: [
        'No path exists',
        'Multiple equal paths',
        'Poor heuristic function'
      ]
    }
  ].freeze

  # Seed algorithms
  ActiveRecord::Base.transaction do
    # Seed Comparison Based Searching
    puts "\nSeeding Comparison Based Searching Algorithms..."
    COMPARISON_SEARCHING_ALGORITHMS.each do |algorithm_data|
      algorithm = comparison_searching.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

    # Seed Graph Based Searching
    puts "\nSeeding Graph Based Searching Algorithms..."
    GRAPH_SEARCHING_ALGORITHMS.each do |algorithm_data|
      algorithm = graph_searching.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

    # Seed Heuristic Based Searching
    puts "\nSeeding Heuristic Based Searching Algorithms..."
    HEURISTIC_SEARCHING_ALGORITHMS.each do |algorithm_data|
      algorithm = heuristic_searching.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

  puts "\nSearching Algorithms seeding completed!"
  puts "Created/Updated:"
  puts "- #{comparison_searching.algorithms.count} Comparison Based Algorithms"
  puts "- #{graph_searching.algorithms.count} Graph Based Algorithms"
  puts "- #{heuristic_searching.algorithms.count} Heuristic Based Algorithms"
end
