# db/seeds/algorithms/01_sorting.seeds.rb
after :shared do
  # Create or find 'Sorting Algorithms' category
  sorting = AlgorithmCategory.find_or_create_by!(
    name: 'Sorting Algorithms'
  ) do |category|
    category.description = 'Algorithms that arrange elements in a specific order'
  end

  # Create or find types under the 'Sorting Algorithms' category
  comparison_sorting = sorting.algorithm_types.find_or_create_by!(
    name: 'Comparison Based Sorting'
  ) do |type|
    type.description = 'Algorithms that sort by comparing elements'
  end

  distribution_sorting = sorting.algorithm_types.find_or_create_by!(
    name: 'Distribution Based Sorting'
  ) do |type|
    type.description = 'Algorithms that sort by distributing elements'
  end

  # Define and seed comparison-based sorting algorithms
  comparison_sorting_algorithms = [
    {
      name: 'Bubble Sort',
      description: 'A simple comparison-based sorting algorithm that repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order.',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner],
      use_cases: ['Small datasets', 'Nearly sorted data', 'Educational purposes'],
      advantages: ['Simple implementation', 'No extra space needed', 'Stable sort'],
      disadvantages: ['Poor performance for large datasets', 'Not suitable for real applications']
    },
    {
      name: 'Selection Sort',
      description: 'An in-place comparison sorting algorithm that divides the input list into a sorted and an unsorted region, iteratively shrinking the unsorted region by selecting the smallest element and adding it to the sorted region.',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: false,
      in_place: true,
      recursive: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner]
    },
    {
      name: 'Insertion Sort',
      description: 'Builds the final sorted array one item at a time by continuously removing one element from the input data and inserting it into its correct position.',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: true,
      in_place: true,
      recursive: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:beginner]
    },
    {
      name: 'Merge Sort',
      description: 'An efficient, stable sorting algorithm that uses divide and conquer to recursively sort and merge two halves.',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linearithmic],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:linearithmic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:linearithmic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:linear],
      stable: true,
      in_place: false,
      recursive: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate]
    },
    {
      name: 'Quick Sort',
      description: 'An efficient in-place sorting algorithm that uses divide and conquer, selecting a pivot and partitioning the elements into two sub-arrays.',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linearithmic],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:linearithmic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:logarithmic],
      stable: false,
      in_place: true,
      recursive: true,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate]
    },
    {
      name: 'Heap Sort',
      description: 'A comparison-based sorting algorithm that uses a binary heap, shrinking the unsorted region by extracting the largest element.',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linearithmic],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:linearithmic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:linearithmic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: false,
      in_place: true,
      recursive: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate]
    },
    {
      name: 'Shell Sort',
      description: 'An in-place comparison sort that generalizes insertion sort by allowing exchanges of items far apart, reducing the gap with each pass.',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:linearithmic],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:quadratic],
      space_complexity: SeedConstants::COMPLEXITY_TYPES[:constant],
      stable: false,
      in_place: true,
      recursive: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate]
    }
  ].freeze

  # Seed comparison-based sorting algorithms
  comparison_sorting_algorithms.each do |algorithm_data|
    algorithm = comparison_sorting.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
      algo.assign_attributes(algorithm_data)
    end

    # Add complexities if not already present
    algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
      complexity.best_case = algorithm_data[:time_complexity_best]
      complexity.average_case = algorithm_data[:time_complexity_average]
      complexity.worst_case = algorithm_data[:time_complexity_worst]
      complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
    end
  end

  # Define and seed distribution-based sorting algorithms
  distribution_sorting_algorithms = [
    {
      name: 'Counting Sort',
      description: 'An integer sorting algorithm that counts each distinct key and uses arithmetic to determine their positions in the output sequence.',
      time_complexity_best: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_average: SeedConstants::COMPLEXITY_TYPES[:linear],
      time_complexity_worst: SeedConstants::COMPLEXITY_TYPES[:linear],
      space_complexity: 'O(k)',  # where k is the range of input
      stable: true,
      in_place: false,
      recursive: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:intermediate]
    },
    {
      name: 'Radix Sort',
      description: 'A non-comparative integer sorting algorithm that groups keys by individual digits sharing the same position and value.',
      time_complexity_best: 'O(nk)',  # k is the number of digits
      time_complexity_average: 'O(nk)',
      time_complexity_worst: 'O(nk)',
      space_complexity: 'O(n + k)',
      stable: true,
      in_place: false,
      recursive: false,
      difficulty_level: SeedConstants::DIFFICULTY_LEVELS[:advanced]
    }
  ].freeze

  # Seed distribution-based sorting algorithms
  distribution_sorting_algorithms.each do |algorithm_data|
    algorithm = distribution_sorting.algorithms.find_or_create_by!(name: algorithm_data[:name]) do |algo|
      algo.assign_attributes(algorithm_data)
    end

    # Add complexities if not already present
    algorithm.complexities.find_or_create_by!(operation_type: 'general') do |complexity|
      complexity.best_case = algorithm_data[:time_complexity_best]
      complexity.average_case = algorithm_data[:time_complexity_average]
      complexity.worst_case = algorithm_data[:time_complexity_worst]
      complexity.explanation = "Time complexity analysis for #{algorithm_data[:name]}"
    end
  end
end
