after :shared do
  tree = AlgorithmCategory.find_or_create_by!(
    name: 'Tree Algorithms',
    description: 'Algorithms that operate on tree data structures'
  )

  # Create Algorithm Types
  traversal = tree.algorithm_types.find_or_create_by!(
    name: 'Tree Traversal',
    description: 'Algorithms for visiting all nodes in a tree'
  )

  balanced_tree = tree.algorithm_types.find_or_create_by!(
    name: 'Balanced Tree Operations',
    description: 'Algorithms for maintaining balanced tree structures'
  )

  special_tree = tree.algorithm_types.find_or_create_by!(
    name: 'Special Tree Operations',
    description: 'Algorithms for specialized tree structures'
  )

  TRAVERSAL_ALGORITHMS = [
    {
      name: 'Inorder Traversal',
      description: 'Traverses left subtree, visits root, then traverses right subtree',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:linear],
      space_complexity: 'O(h)', # h: height of tree
      stable: true,
      in_place: false,
      recursive: true,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner],
      use_cases: [
        'Binary Search Tree traversal',
        'Expression tree evaluation',
        'Sorted sequence generation'
      ],
      advantages: [
        'Visits nodes in sorted order for BST',
        'Simple recursive implementation',
        'Natural order for expression trees'
      ],
      disadvantages: [
        'Stack space for recursion',
        'Not suitable for parallel processing',
        'Stack overflow for deep trees'
      ],
      edge_cases: [
        'Empty tree',
        'Single node',
        'Skewed tree'
      ]
    },
    {
      name: 'Preorder Traversal',
      description: 'Visits root, then traverses left subtree, then right subtree',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:linear],
      space_complexity: 'O(h)',
      stable: true,
      in_place: false,
      recursive: true,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner],
      use_cases: [
        'Tree copying',
        'Prefix expression parsing',
        'Directory structure processing'
      ],
      advantages: [
        'Root processed first',
        'Good for tree structure copying',
        'Natural for prefix expressions'
      ],
      disadvantages: [
        'Stack space requirement',
        'Not sorted order for BST',
        'Recursive overhead'
      ]
    },
    {
      name: 'Postorder Traversal',
      description: 'Traverses left subtree, right subtree, then visits root',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:linear],
      space_complexity: 'O(h)',
      stable: true,
      in_place: false,
      recursive: true,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner],
      use_cases: [
        'Tree deletion',
        'Postfix expression evaluation',
        'Directory size calculation'
      ],
      advantages: [
        'Children processed before parent',
        'Good for cleanup operations',
        'Suitable for expression evaluation'
      ],
      disadvantages: [
        'Complex iterative implementation',
        'Stack overhead',
        'Not intuitive ordering'
      ]
    }
  ].freeze

  BALANCED_TREE_ALGORITHMS = [
    {
      name: 'AVL Tree Balancing',
      description: 'Self-balancing binary search tree operations maintaining strict balance',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      stable: true,
      in_place: false,
      recursive: true,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Database indexing',
        'In-memory sorted data',
        'Real-time applications'
      ],
      advantages: [
        'Strictly balanced',
        'Guaranteed O(log n) operations',
        'Simple balance factor'
      ],
      disadvantages: [
        'Complex rotations',
        'Extra space for height info',
        'More rotations than Red-Black'
      ]
    },
    {
      name: 'Red-Black Tree Operations',
      description: 'Self-balancing binary search tree with relaxed balancing conditions',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Standard library implementations',
        'System programming',
        'Game development'
      ],
      advantages: [
        'Fewer rotations than AVL',
        'Good general-purpose balance',
        'Used in many libraries'
      ],
      disadvantages: [
        'Complex implementation',
        'Extra space for color',
        'Not strictly balanced'
      ]
    }
  ].freeze

  SPECIAL_TREE_ALGORITHMS = [
    {
      name: 'B-Tree Operations',
      description: 'Self-balancing tree optimized for disk operations with multiple keys per node',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      space_complexity: 'O(n)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:expert],
      use_cases: [
        'File systems',
        'Database indexing',
        'Multi-level indexing'
      ],
      advantages: [
        'Optimized for disk operations',
        'Reduces disk seeks',
        'Handles large datasets'
      ],
      disadvantages: [
        'Complex implementation',
        'Memory overhead',
        'Complex node splitting'
      ]
    },
    {
      name: 'Trie Operations',
      description: 'Specialized tree for storing and retrieving strings, with shared prefixes',
      time_complexity_best: 'O(k)', # k: key length
      time_complexity_average: 'O(k)',
      time_complexity_worst: 'O(k)',
      space_complexity: 'O(ALPHABET_SIZE * n)',
      stable: true,
      in_place: false,
      recursive: true,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Autocomplete',
        'Spell checkers',
        'IP routing tables',
        'Dictionary implementations'
      ],
      advantages: [
        'Fast string operations',
        'Prefix-based search',
        'No hash collisions'
      ],
      disadvantages: [
        'Space intensive',
        'Not good for non-string data',
        'Complex deletion'
      ]
    }
  ].freeze

  # Seed algorithms
  ActiveRecord::Base.transaction do
    # Seed Traversal Algorithms
    puts "\nSeeding Tree Traversal Algorithms..."
    TRAVERSAL_ALGORITHMS.each do |algorithm_data|
      algorithm = traversal.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

    # Seed Balanced Tree Algorithms
    puts "\nSeeding Balanced Tree Algorithms..."
    BALANCED_TREE_ALGORITHMS.each do |algorithm_data|
      algorithm = balanced_tree.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

    # Seed Special Tree Algorithms
    puts "\nSeeding Special Tree Algorithms..."
    SPECIAL_TREE_ALGORITHMS.each do |algorithm_data|
      algorithm = special_tree.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

  puts "\nTree Algorithms seeding completed!"
  puts "Created/Updated:"
  puts "- #{traversal.algorithms.count} Tree Traversal Algorithms"
  puts "- #{balanced_tree.algorithms.count} Balanced Tree Algorithms"
  puts "- #{special_tree.algorithms.count} Special Tree Algorithms"
end
