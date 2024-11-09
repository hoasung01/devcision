after :shared do
  greedy = AlgorithmCategory.find_or_create_by!(
    name: 'Greedy Algorithms',
    description: 'Algorithms that make locally optimal choices at each step to find a global optimum'
  )

  # Create Algorithm Types
  optimization = greedy.algorithm_types.find_or_create_by!(
    name: 'Optimization Problems',
    description: 'Algorithms that optimize resource allocation and utilization'
  )

  scheduling = greedy.algorithm_types.find_or_create_by!(
    name: 'Scheduling Problems',
    description: 'Algorithms for task and resource scheduling'
  )

  # Note: We're not creating duplicate graph optimization algorithms here
  # since they're already in the Graph Algorithms category

  OPTIMIZATION_ALGORITHMS = [
    {
      name: 'Huffman Coding',
      description: 'Data compression algorithm that assigns variable-length codes to characters based on their frequencies',
      time_complexity_best: 'O(n log n)', # n: number of unique characters
      time_complexity_average: 'O(n log n)',
      time_complexity_worst: 'O(n log n)',
      space_complexity: 'O(n)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Text compression',
        'File compression',
        'Data transmission',
        'Image compression'
      ],
      advantages: [
        'Optimal prefix codes',
        'Lossless compression',
        'Adaptable to data patterns',
        'Simple decompression'
      ],
      disadvantages: [
        'Requires frequency information',
        'Two passes over data',
        'Overhead for rare symbols',
        'Static encoding'
      ],
      edge_cases: [
        'Single character input',
        'All characters equal frequency',
        'Very skewed frequencies'
      ]
    },
    {
      name: 'Fractional Knapsack',
      description: 'Algorithm to maximize value selection where items can be broken into smaller units',
      time_complexity_best: 'O(n log n)', # n: number of items
      time_complexity_average: 'O(n log n)',
      time_complexity_worst: 'O(n log n)',
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner],
      use_cases: [
        'Resource allocation',
        'Investment portfolios',
        'Cargo loading',
        'Budget optimization'
      ],
      advantages: [
        'Always finds optimal solution',
        'Simple implementation',
        'Efficient time complexity',
        'Handles fractional quantities'
      ],
      disadvantages: [
        'Only works with divisible items',
        'Not suitable for discrete items',
        'Requires sorting',
        'Limited application scope'
      ],
      edge_cases: [
        'Empty input',
        'Single item',
        'All items same value/weight ratio'
      ]
    }
  ].freeze

  SCHEDULING_ALGORITHMS = [
    {
      name: 'Job Scheduling',
      description: 'Algorithm to schedule jobs to minimize completion time or maximize profit',
      time_complexity_best: 'O(n log n)', # n: number of jobs
      time_complexity_average: 'O(n log n)',
      time_complexity_worst: 'O(n log n)',
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:linear],
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'CPU scheduling',
        'Task management',
        'Project planning',
        'Resource allocation'
      ],
      advantages: [
        'Minimizes total completion time',
        'Simple sorting-based approach',
        'Works well with deadlines',
        'Adaptable to different metrics'
      ],
      disadvantages: [
        'May not find global optimum',
        'Cannot handle dependencies',
        'Sensitive to input ordering',
        'Limited constraint handling'
      ],
      edge_cases: [
        'Equal duration jobs',
        'All jobs same profit',
        'Conflicting deadlines'
      ]
    }
  ].freeze

  # Seed algorithms
  ActiveRecord::Base.transaction do
    # Seed Optimization Algorithms
    puts "\nSeeding Optimization Algorithms..."
    OPTIMIZATION_ALGORITHMS.each do |algorithm_data|
      algorithm = optimization.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

    # Seed Scheduling Algorithms
    puts "\nSeeding Scheduling Algorithms..."
    SCHEDULING_ALGORITHMS.each do |algorithm_data|
      algorithm = scheduling.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

    # Note about graph algorithms
    puts "\nNote: Dijkstra's and Prim's algorithms are already seeded in the Graph Algorithms category."
  end

  puts "\nGreedy Algorithms seeding completed!"
  puts "Created/Updated:"
  puts "- #{optimization.algorithms.count} Optimization Algorithms"
  puts "- #{scheduling.algorithms.count} Scheduling Algorithms"
  puts "Note: Graph optimization algorithms are in Graph Algorithms category"
end
