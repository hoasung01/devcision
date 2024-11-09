after :shared do
  computational_geometry = AlgorithmCategory.find_or_create_by!(
    name: 'Computational Geometry Algorithms',
    description: 'Algorithms that solve geometric problems computationally'
  )

  convex_hull = computational_geometry.algorithm_types.find_or_create_by!(
    name: 'Convex Hull',
    description: 'Algorithms for finding the smallest convex polygon containing all points'
  )

  geometric_operations = computational_geometry.algorithm_types.find_or_create_by!(
    name: 'Geometric Operations',
    description: 'Algorithms for basic geometric computations'
  )

  CONVEX_HULL_ALGORITHMS = [
    {
      name: 'Graham Scan',
      description: 'Algorithm for finding the convex hull of a set of points in a plane',
      time_complexity_best: 'O(n log n)', # n: number of points
      time_complexity_average: 'O(n log n)',
      time_complexity_worst: 'O(n log n)',
      space_complexity: 'O(n)',
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Computer graphics',
        'Pattern recognition',
        'Image processing',
        'Collision detection'
      ],
      advantages: [
        'Optimal time complexity',
        'Works with arbitrary point sets',
        'Simple to implement',
        'Handles collinear points'
      ],
      disadvantages: [
        'Requires sorting step',
        'Not suitable for 3D hulls',
        'Sensitive to numerical precision',
        'Memory overhead'
      ],
      edge_cases: [
        'All points collinear',
        'All points identical',
        'Triangle cases',
        'Empty point set'
      ]
    }
  ].freeze

  GEOMETRIC_OPERATIONS_ALGORITHMS = [
    {
      name: 'Line Intersection',
      description: 'Algorithm to determine if two line segments intersect',
      time_complexity_best: 'O(1)',
      time_complexity_average: 'O(1)',
      time_complexity_worst: 'O(1)',
      space_complexity: 'O(1)',
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Collision detection',
        'Computer graphics',
        'Map overlay',
        'Geometric modeling'
      ],
      advantages: [
        'Constant time complexity',
        'Simple implementation',
        'Handles all cases',
        'Numerically stable'
      ],
      disadvantages: [
        'Floating point precision issues',
        'Special cases handling',
        'Limited to 2D',
        'Degenerate cases'
      ],
      edge_cases: [
        'Parallel lines',
        'Overlapping lines',
        'Endpoint intersections',
        'Vertical lines'
      ]
    },
    {
      name: 'Point in Polygon',
      description: 'Algorithm to determine if a point lies inside a polygon',
      time_complexity_best: 'O(n)', # n: number of vertices
      time_complexity_average: 'O(n)',
      time_complexity_worst: 'O(n)',
      space_complexity: 'O(1)',
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Geographic information systems',
        'Computer graphics',
        'Game development',
        'Map applications'
      ],
      advantages: [
        'Works for any polygon',
        'Memory efficient',
        'Simple ray casting approach',
        'Handles irregular shapes'
      ],
      disadvantages: [
        'Linear time complexity',
        'Edge cases handling',
        'Floating point precision',
        'Not suitable for real-time'
      ],
      edge_cases: [
        'Point on edge',
        'Point on vertex',
        'Self-intersecting polygons',
        'Holes in polygon'
      ]
    }
  ].freeze

  # Seed algorithms
  ActiveRecord::Base.transaction do
    # Seed Convex Hull Algorithms
    puts "\nSeeding Convex Hull Algorithms..."
    CONVEX_HULL_ALGORITHMS.each do |algorithm_data|
      algorithm = convex_hull.algorithms.find_or_initialize_by(name: algorithm_data[:name])
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

    # Seed Geometric Operations Algorithms
    puts "\nSeeding Geometric Operations Algorithms..."
    GEOMETRIC_OPERATIONS_ALGORITHMS.each do |algorithm_data|
      algorithm = geometric_operations.algorithms.find_or_initialize_by(name: algorithm_data[:name])
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

  puts "\nComputational Geometry Algorithms seeding completed!"
  puts "Created/Updated:"
  puts "- #{convex_hull.algorithms.count} Convex Hull Algorithms"
  puts "- #{geometric_operations.algorithms.count} Geometric Operations Algorithms"
end
