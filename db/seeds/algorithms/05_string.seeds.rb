after :shared do
  string = AlgorithmCategory.find_or_create_by!(
    name: 'String Algorithms',
    description: 'Algorithms that process and analyze text strings'
  )

  # Create Algorithm Types
  pattern_matching = string.algorithm_types.find_or_create_by!(
    name: 'Pattern Matching',
    description: 'Algorithms for finding patterns within text'
  )

  string_analysis = string.algorithm_types.find_or_create_by!(
    name: 'String Analysis',
    description: 'Algorithms for analyzing string properties and characteristics'
  )

  string_processing = string.algorithm_types.find_or_create_by!(
    name: 'String Processing',
    description: 'Algorithms for efficient string manipulation and processing'
  )

  # Define Algorithms
  PATTERN_MATCHING_ALGORITHMS = [
    {
      name: 'Naive Pattern Matching',
      description: 'Simple algorithm that checks for pattern matches at every position in the text',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: 'O(mn)', # m: pattern length, n: text length
      time_complexity_worst: 'O(mn)',
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner],
      use_cases: [
        'Short patterns',
        'Simple text search',
        'Educational purposes',
        'Small text processing'
      ],
      advantages: [
        'Simple implementation',
        'No preprocessing needed',
        'Works with any character set'
      ],
      disadvantages: [
        'Inefficient for large texts',
        'Poor performance for repetitive patterns',
        'Quadratic time complexity'
      ],
      edge_cases: [
        'Empty text or pattern',
        'Pattern longer than text',
        'All characters same'
      ]
    },
    {
      name: 'KMP Algorithm',
      description: 'Knuth-Morris-Pratt algorithm that utilizes pattern preprocessing to avoid unnecessary comparisons',
      time_complexity_best: 'O(n)', # n: text length
      time_complexity_average: 'O(n)',
      time_complexity_worst: 'O(n)',
      space_complexity: 'O(m)', # m: pattern length
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Text editors',
        'DNA sequence matching',
        'Network packet inspection',
        'Pattern searching in streams'
      ],
      advantages: [
        'Linear time complexity',
        'No backtracking needed',
        'Efficient for repetitive patterns'
      ],
      disadvantages: [
        'Preprocessing overhead',
        'Extra space for LPS array',
        'Complex implementation'
      ],
      edge_cases: [
        'Periodic patterns',
        'Pattern with repeated prefixes',
        'Single character text/pattern'
      ]
    },
    {
      name: 'Rabin-Karp Algorithm',
      description: 'String matching algorithm using hashing for efficient comparison',
      time_complexity_best: 'O(n + m)', # n: text length, m: pattern length
      time_complexity_average: 'O(n + m)',
      time_complexity_worst: 'O(nm)',
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Multiple pattern matching',
        'Plagiarism detection',
        'Document similarity',
        'Cryptographic applications'
      ],
      advantages: [
        'Good for multiple pattern search',
        'Rolling hash efficiency',
        'Suitable for strings and numbers'
      ],
      disadvantages: [
        'Hash collision handling needed',
        'Complex hash function required',
        'Poor worst-case complexity'
      ],
      edge_cases: [
        'Hash collisions',
        'Very short patterns',
        'Large prime numbers needed'
      ]
    },
    {
      name: 'Boyer-Moore Algorithm',
      description: 'Pattern matching algorithm that scans characters from right to left',
      time_complexity_best: 'O(n/m)', # n: text length, m: pattern length
      time_complexity_average: 'O(n/m)',
      time_complexity_worst: 'O(nm)',
      space_complexity: 'O(k)', # k: alphabet size
      stable: true,
      in_place: false,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced],
      use_cases: [
        'Text editors',
        'Large text searching',
        'Unix grep command',
        'Binary file scanning'
      ],
      advantages: [
        'Very fast in practice',
        'Sublinear time possible',
        'Better for larger alphabets'
      ],
      disadvantages: [
        'Complex preprocessing',
        'Space for bad character rule',
        'Not optimal for small alphabets'
      ],
      edge_cases: [
        'Binary data',
        'Small alphabets',
        'Highly repetitive text'
      ]
    }
  ].freeze

  STRING_ANALYSIS_ALGORITHMS = [
    {
      name: 'Longest Palindromic Substring',
      description: 'Algorithm to find the longest substring that reads the same forwards and backwards',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'Text analysis',
        'DNA sequence analysis',
        'String processing',
        'Palindrome detection'
      ],
      advantages: [
        'Can handle odd and even length palindromes',
        'Space efficient',
        'Simple implementation available'
      ],
      disadvantages: [
        'Quadratic time complexity',
        'Not optimal for very long strings',
        'Multiple solutions possible'
      ],
      edge_cases: [
        'Empty string',
        'Single character',
        'All characters same'
      ]
    },
    {
      name: 'String Hashing',
      description: 'Algorithm for converting strings into numerical values for efficient comparison',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:linear],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      parallel_possible: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate],
      use_cases: [
        'String comparison',
        'Pattern matching',
        'Dictionary operations',
        'Cryptographic applications'
      ],
      advantages: [
        'Fast string comparison',
        'Constant time equality check',
        'Good for dictionary operations'
      ],
      disadvantages: [
        'Hash collision possibility',
        'Need good hash function',
        'Security considerations'
      ],
      edge_cases: [
        'Hash collisions',
        'Very long strings',
        'Special characters'
      ]
    }
  ].freeze

  # Seed algorithms
  ActiveRecord::Base.transaction do
    # Seed Pattern Matching Algorithms
    puts "\nSeeding Pattern Matching Algorithms..."
    PATTERN_MATCHING_ALGORITHMS.each do |algorithm_data|
      algorithm = pattern_matching.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

    # Seed String Analysis Algorithms
    puts "\nSeeding String Analysis Algorithms..."
    STRING_ANALYSIS_ALGORITHMS.each do |algorithm_data|
      algorithm = string_analysis.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
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

  puts "\nString Algorithms seeding completed!"
  puts "Created/Updated:"
  puts "- #{pattern_matching.algorithms.count} Pattern Matching Algorithms"
  puts "- #{string_analysis.algorithms.count} String Analysis Algorithms"
end
