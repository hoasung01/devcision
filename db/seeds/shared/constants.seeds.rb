module SeedConstants
  COMPLEXITY_TYPES = {
    constant: 'O(1)',
    logarithmic: 'O(log n)',
    linear: 'O(n)',
    linearithmic: 'O(n log n)',
    quadratic: 'O(n²)',
    cubic: 'O(n³)',
    exponential: 'O(2^n)',
    factorial: 'O(n!)'
  }.freeze

  DIFFICULTY_LEVELS = {
    beginner: 1,
    intermediate: 2,
    advanced: 3,
    expert: 4
  }.freeze
end
