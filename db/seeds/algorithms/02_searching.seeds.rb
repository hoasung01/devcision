after :shared do
  def seed_algorithm(type, algorithm_data)
    algorithm = type.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
      algo.assign_attributes(algorithm_data)
    end

    algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
      complexity.best_case = algorithm_data[:time_complexity_best]
      complexity.average_case = algorithm_data[:time_complexity_average]
      complexity.worst_case = algorithm_data[:time_complexity_worst]
      complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
    end

    algorithm
  end

  # Create or find the Searching category
  searching = AlgorithmCategory.find_or_create_by!(name: 'Searching Algorithms') do |category|
    category.description = 'Algorithms designed to find elements within data structures and graphs'
  end

  # Create or find algorithm types
  basic_searching = searching.algorithm_types.find_or_create_by!(name: 'Basic Searching') do |type|
    type.description = 'Fundamental searching algorithms for arrays and lists'
  end

  graph_searching = searching.algorithm_types.find_or_create_by!(name: 'Graph Searching') do |type|
    type.description = 'Algorithms for traversing and searching within graph structures'
  end

  advanced_searching = searching.algorithm_types.find_or_create_by!(name: 'Advanced Searching') do |type|
    type.description = 'Sophisticated searching algorithms with specific optimizations or use cases'
  end

  # Define algorithms data
  BASIC_SEARCHING_ALGORITHMS = [
    {
      name: 'Linear Search',
      description: 'Simple search algorithm that checks each element in the sequence until the desired element is found.',
      time_complexity_best: COMPLEXITY_TYPES[:constant],
      time_complexity_average: COMPLEXITY_TYPES[:linear],
      time_complexity_worst: COMPLEXITY_TYPES[:linear],
      space_complexity: COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      difficulty_level: DIFFICULTY_LEVELS[:beginner],
      use_cases: [
        'Small datasets',
        'Unsorted arrays',
        'When data structure doesn\'t support random access',
        'When searching for multiple occurrences'
      ],
      advantages: [
        'Simple to implement',
        'Works on unsorted arrays',
        'No extra space needed',
        'Works on any data structure',
        'Can find all occurrences'
      ],
      disadvantages: [
        'Slow for large datasets',
        'Not efficient for sorted arrays',
        'Linear time complexity'
      ]
    },
    {
      name: 'Binary Search',
      description: 'Efficient search algorithm that finds the position of a target value within a sorted array by repeatedly dividing the search space in half.',
      time_complexity_best: COMPLEXITY_TYPES[:constant],
      time_complexity_average: COMPLEXITY_TYPES[:logarithmic],
      time_complexity_worst: COMPLEXITY_TYPES[:logarithmic],
      space_complexity: COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: true,
      difficulty_level: DIFFICULTY_LEVELS[:beginner],
      use_cases: [
        'Sorted arrays',
        'Large datasets',
        'When data is frequently searched',
        'Dictionary/phonebook-like applications'
      ],
      advantages: [
        'Very efficient for large sorted datasets',
        'Logarithmic time complexity',
        'Minimal space requirement',
        'Predictable performance'
      ],
      disadvantages: [
        'Requires sorted array',
        'Only works with random access data structures',
        'Requires extra maintenance for dynamic data'
      ]
    },
    {
      name: 'Jump Search',
      description: 'Search algorithm that skips a fixed number of elements and then performs a linear search.',
      time_complexity_best: COMPLEXITY_TYPES[:constant],
      time_complexity_average: 'O(√n)',
      time_complexity_worst: 'O(√n)',
      space_complexity: COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      difficulty_level: DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Sorted arrays',
        'When element is relatively close to beginning',
        'Medium-sized datasets'
      ],
      advantages: [
        'Better than linear search',
        'Good for medium-sized arrays',
        'Simpler than binary search',
        'Works well on systems where jumping back is cheaper than reading elements'
      ],
      disadvantages: [
        'Requires sorted array',
        'Not as efficient as binary search',
        'Jump size needs to be chosen carefully'
      ]
    },
    {
      name: 'Interpolation Search',
      description: 'Improved variant of binary search that uses the value of the target element to compute probable position.',
      time_complexity_best: COMPLEXITY_TYPES[:constant],
      time_complexity_average: 'O(log log n)',
      time_complexity_worst: COMPLEXITY_TYPES[:linear],
      space_complexity: COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: true,
      difficulty_level: DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Sorted arrays with uniform distribution',
        'Telephone directories',
        'Dictionaries'
      ],
      advantages: [
        'Very fast for uniformly distributed sorted arrays',
        'Can outperform binary search',
        'Works well with large datasets'
      ],
      disadvantages: [
        'Complex implementation',
        'Poor performance on non-uniform distributions',
        'Requires sorted array'
      ]
    }
  ].freeze

  GRAPH_SEARCHING_ALGORITHMS = [
    {
      name: 'Depth-First Search (DFS)',
      description: 'Graph traversal algorithm that explores as far as possible along each branch before backtracking.',
      time_complexity_best: COMPLEXITY_TYPES[:linear],
      time_complexity_average: 'O(V + E)', # V vertices, E edges
      time_complexity_worst: 'O(V + E)',
      space_complexity: 'O(V)',
      stable: true,
      in_place: false,
      recursive: true,
      difficulty_level: DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Topological sorting',
        'Finding connected components',
        'Solving puzzles with only one solution',
        'Path finding in maze problems'
      ],
      advantages: [
        'Memory efficient for deep graphs',
        'Solution found without exploring all nodes',
        'Naturally recursive',
        'Good for topological sorting'
      ],
      disadvantages: [
        'Can get stuck in infinite depths without proper handling',
        'Not guaranteed to find shortest path',
        'May need stack size handling for very deep graphs'
      ]
    },
    {
      name: 'Breadth-First Search (BFS)',
      description: 'Graph traversal algorithm that explores all vertices at current depth before moving to vertices at next depth level.',
      time_complexity_best: COMPLEXITY_TYPES[:linear],
      time_complexity_average: 'O(V + E)',
      time_complexity_worst: 'O(V + E)',
      space_complexity: 'O(V)',
      stable: true,
      in_place: false,
      recursive: false,
      difficulty_level: DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Finding shortest path on unweighted graphs',
        'Level order traversal',
        'Finding all nodes within one connected component',
        'Testing bipartiteness'
      ],
      advantages: [
        'Finds shortest path in unweighted graphs',
        'Visits nodes in order of distance from start',
        'Good for finding closest elements'
      ],
      disadvantages: [
        'Uses more memory than DFS',
        'Not memory efficient for very wide graphs',
        'May be slower than DFS for finding simple paths'
      ]
    }
  ].freeze

  ADVANCED_SEARCHING_ALGORITHMS = [
    {
      name: 'A* Search',
      description: 'Best-first search algorithm that uses heuristics to find the shortest path between nodes in a graph.',
      time_complexity_best: COMPLEXITY_TYPES[:linear],
      time_complexity_average: 'O(b^d)', # b: branching factor, d: depth
      time_complexity_worst: 'O(b^d)',
      space_complexity: 'O(b^d)',
      stable: true,
      in_place: false,
      recursive: false,
      difficulty_level: DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Pathfinding in games',
        'Robot navigation',
        'GPS and navigation systems',
        'Puzzle solving'
      ],
      advantages: [
        'Optimal path finding with admissible heuristic',
        'More efficient than Dijkstra with good heuristic',
        'Flexible for different heuristic functions',
        'Complete when properly implemented'
      ],
      disadvantages: [
        'Memory intensive',
        'Requires good heuristic function',
        'May not be suitable for memory-constrained systems',
        'Can be slower than simpler algorithms for small graphs'
      ]
    }
  ].freeze

  # Seed algorithms with find_or_create_by
  ActiveRecord::Base.transaction do
    puts "\nSeeding Basic Searching Algorithms..."
    BASIC_SEARCHING_ALGORITHMS.each do |algorithm_data|
      seed_algorithm(basic_searching, algorithm_data)
      print "."
    end

    puts "\nSeeding Graph Searching Algorithms..."
    GRAPH_SEARCHING_ALGORITHMS.each do |algorithm_data|
      seed_algorithm(graph_searching, algorithm_data)
      print "."
    end

    puts "\nSeeding Advanced Searching Algorithms..."
    ADVANCED_SEARCHING_ALGORITHMS.each do |algorithm_data|
      seed_algorithm(advanced_searching, algorithm_data)
      print "."
    end
  end

  puts "\nSearching Algorithms seeding completed!"
  puts "Created/Updated:"
  puts "- #{basic_searching.algorithms.count} Basic Searching Algorithms"
  puts "- #{graph_searching.algorithms.count} Graph Searching Algorithms"
  puts "- #{advanced_searching.algorithms.count} Advanced Searching Algorithms"
end
