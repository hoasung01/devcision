after :shared do
  graph = AlgorithmCategory.find_or_create_by!(
    name: 'Graph Algorithms',
    description: 'Algorithms that solve problems related to graph data structures'
  )

  # Create Algorithm Types
  shortest_path = graph.algorithm_types.find_or_create_by!(
    name: 'Shortest Path Algorithms',
    description: 'Algorithms for finding shortest paths between nodes in a graph'
  )

  minimum_spanning = graph.algorithm_types.find_or_create_by!(
    name: 'Minimum Spanning Tree Algorithms',
    description: 'Algorithms for finding minimum spanning trees in weighted graphs'
  )

  graph_utility = graph.algorithm_types.find_or_create_by!(
    name: 'Graph Utility Algorithms',
    description: 'Algorithms for various graph operations and analysis'
  )

  # Define Algorithms
  SHORTEST_PATH_ALGORITHMS = [
    {
      name: "Dijkstra's Algorithm",
      description: 'Algorithm for finding the shortest paths between nodes in a graph with non-negative edge weights',
      time_complexity_best: 'O((V + E) log V)',
      time_complexity_average: 'O((V + E) log V)',
      time_complexity_worst: 'O((V + E) log V)',
      space_complexity: 'O(V)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'GPS and navigation systems',
        'Network routing protocols',
        'Social networking',
        'Games pathfinding'
      ],
      advantages: [
        'Optimal for single-source shortest path',
        'Works with any graph with non-negative weights',
        'Can be modified for specific needs'
      ],
      disadvantages: [
        'Doesn\'t work with negative weights',
        'Relatively slow for unweighted graphs',
        'High memory usage for dense graphs'
      ],
      edge_cases: [
        'Negative edge weights',
        'Disconnected graphs',
        'Dense graphs',
        'All edges same weight'
      ]
    },
    {
      name: 'Bellman-Ford Algorithm',
      description: 'Algorithm for finding shortest paths from a source vertex to all other vertices in a weighted graph',
      time_complexity_best: 'O(V + E)',
      time_complexity_average: 'O(VE)',
      time_complexity_worst: 'O(VE)',
      space_complexity: 'O(V)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Networks with negative weights',
        'Detecting negative cycles',
        'Distance vector routing'
      ],
      advantages: [
        'Works with negative edge weights',
        'Detects negative cycles',
        'Simpler than Dijkstra'
      ],
      disadvantages: [
        'Slower than Dijkstra',
        'Not suitable for large graphs',
        'Higher time complexity'
      ],
      edge_cases: [
        'Negative cycles',
        'Disconnected components',
        'Long paths with negative edges'
      ]
    },
    {
      name: 'Floyd-Warshall Algorithm',
      description: 'Algorithm for finding shortest paths between all pairs of vertices in a weighted graph',
      time_complexity_best: 'O(V³)',
      time_complexity_average: 'O(V³)',
      time_complexity_worst: 'O(V³)',
      space_complexity: 'O(V²)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'All-pairs shortest paths',
        'Path reconstruction',
        'Network optimization',
        'Graph analysis'
      ],
      advantages: [
        'Solves all pairs shortest paths',
        'Works with negative weights',
        'Simple implementation'
      ],
      disadvantages: [
        'Cubic time complexity',
        'Quadratic space complexity',
        'Not suitable for large graphs'
      ],
      edge_cases: [
        'Negative cycles',
        'Sparse graphs',
        'Large graphs'
      ]
    }
  ].freeze

  MINIMUM_SPANNING_ALGORITHMS = [
    {
      name: "Kruskal's Algorithm",
      description: 'Greedy algorithm that finds a minimum spanning tree for a connected weighted graph',
      time_complexity_best: 'O(E log E)',
      time_complexity_average: 'O(E log E)',
      time_complexity_worst: 'O(E log E)',
      space_complexity: 'O(V)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Network design',
        'Cluster analysis',
        'Circuit design',
        'Transportation networks'
      ],
      advantages: [
        'Works well for sparse graphs',
        'Easy to implement with Union-Find',
        'Guaranteed optimal solution'
      ],
      disadvantages: [
        'Requires sorting edges',
        'Not as efficient for dense graphs',
        'Requires Union-Find data structure'
      ],
      edge_cases: [
        'Disconnected graphs',
        'Equal weight edges',
        'Complete graphs'
      ]
    },
    {
      name: "Prim's Algorithm",
      description: 'Greedy algorithm that finds a minimum spanning tree for a weighted undirected graph',
      time_complexity_best: 'O(E log V)',
      time_complexity_average: 'O(E log V)',
      time_complexity_worst: 'O(E log V)',
      space_complexity: 'O(V)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Network design',
        'Power/water distribution',
        'Circuit design optimization'
      ],
      advantages: [
        'Better for dense graphs',
        'Simpler with priority queue',
        'Grows single tree from start'
      ],
      disadvantages: [
        'Not suitable for disconnected graphs',
        'Requires priority queue for efficiency',
        'Memory intensive'
      ],
      edge_cases: [
        'Disconnected graphs',
        'Equal weight edges',
        'Dense vs sparse graphs'
      ]
    }
  ].freeze

  GRAPH_UTILITY_ALGORITHMS = [
    {
      name: 'Topological Sort',
      description: 'Algorithm for linearly ordering the vertices of a directed acyclic graph',
      time_complexity_best: 'O(V + E)',
      time_complexity_average: 'O(V + E)',
      time_complexity_worst: 'O(V + E)',
      space_complexity: 'O(V)',
      stable: false,
      in_place: false,
      recursive: true,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Task scheduling',
        'Build systems',
        'Course prerequisites',
        'Program compilation'
      ],
      advantages: [
        'Linear time complexity',
        'Detects cycles',
        'Multiple valid orderings possible'
      ],
      disadvantages: [
        'Only works on DAGs',
        'Not unique solution',
        'Requires careful cycle detection'
      ],
      edge_cases: [
        'Cyclic graphs',
        'Single path graphs',
        'Empty graphs'
      ]
    },
    {
      name: "Floyd's Cycle Detection",
      description: 'Algorithm for detecting cycles in a linked list or graph using two pointers',
      time_complexity_best: 'O(n)',
      time_complexity_average: 'O(n)',
      time_complexity_worst: 'O(n)',
      space_complexity: 'O(1)',
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Detecting loops in linked lists',
        'Cycle detection in graphs',
        'Finding repeated elements'
      ],
      advantages: [
        'Constant extra space',
        'Simple implementation',
        'Also finds cycle length'
      ],
      disadvantages: [
        'Only finds one cycle',
        'Doesn\'t work for all graph types',
        'Can\'t find all cycles'
      ],
      edge_cases: [
        'No cycle',
        'Multiple cycles',
        'Single element cycle'
      ]
    }
  ].freeze

  # Seed algorithms
  ActiveRecord::Base.transaction do
    # Seed Shortest Path Algorithms
    puts "\nSeeding Shortest Path Algorithms..."
    SHORTEST_PATH_ALGORITHMS.each do |algorithm_data|
      algorithm = shortest_path.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

    # Seed Minimum Spanning Tree Algorithms
    puts "\nSeeding Minimum Spanning Tree Algorithms..."
    MINIMUM_SPANNING_ALGORITHMS.each do |algorithm_data|
      algorithm = minimum_spanning.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

    # Seed Graph Utility Algorithms
    puts "\nSeeding Graph Utility Algorithms..."
    GRAPH_UTILITY_ALGORITHMS.each do |algorithm_data|
      algorithm = graph_utility.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

  puts "\nGraph Algorithms seeding completed!"
  puts "Created/Updated:"
  puts "- #{shortest_path.algorithms.count} Shortest Path Algorithms"
  puts "- #{minimum_spanning.algorithms.count} Minimum Spanning Tree Algorithms"
  puts "- #{graph_utility.algorithms.count} Graph Utility Algorithms"
end
