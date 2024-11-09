# Devcision

## Table of Contents

- [Devcision](#devcision)
  - [Table of Contents](#table-of-contents)
  - [Setup](#setup)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Database Structure](#database-structure)
    - [Main Models](#main-models)
  - [Seeds](#seeds)
    - [Loading Seeds](#loading-seeds)
  - [Usage](#usage)
    - [Accessing Algorithms](#accessing-algorithms)
  - [Contributing](#contributing)
  - [License](#license)

## Setup

### Prerequisites

- Ruby 3.3.3
- Rails 7.1.3 or higher
- PostgreSQL

### Installation

1. Clone the repository

```bash
git clone git@github.com:hoasung01/devcision.git
cd devcision
```

2. Install dependencies

```bash
bundle install
```

3. Add the following gems to your Gemfile:

```ruby
# Gemfile
gem 'seedbank'     # For organized seed data
gem 'faker'        # For generating sample data
gem 'parallel'     # For parallel seed execution
gem 'progress_bar' # For showing seed progress
```

4. Setup database

```bash
rails db:create
rails db:migrate
```

## Database Structure

The database is organized hierarchically:

```ruby
AlgorithmCategory
├── AlgorithmType
│   └── Algorithm
│       ├── AlgorithmImplementation
│       ├── AlgorithmComplexity
│       ├── AlgorithmExample
│       └── AlgorithmBenchmark
```

### Main Models

- `AlgorithmCategory`: High-level categories (Sorting, Searching, etc.)
- `AlgorithmType`: Specific types within categories (Comparison-based sorting, etc.)
- `Algorithm`: Individual algorithms with their characteristics
- `AlgorithmImplementation`: Code implementations in various languages
- `AlgorithmComplexity`: Time and space complexity analysis
- `AlgorithmExample`: Usage examples and test cases
- `AlgorithmBenchmark`: Performance benchmarks

## Seeds

The seed data is organized in categories:

```ruby
db/
└── seeds/
    ├── shared/
    │   └── constants.rb
    └── algorithms/
        ├── 01_sorting.seeds.rb
        ├── 02_searching.seeds.rb
        ├── 03_graph.seeds.rb
        ├── 04_dynamic_programming.seeds.rb
        ├── 05_string.seeds.rb
        ├── 06_tree.seeds.rb
        ├── 07_greedy.seeds.rb
        ├── 08_divide_conquer.seeds.rb
        ├── 09_backtracking.seeds.rb
        ├── 10_computational_geometry.seeds.rb
        └── 11_numerical.seeds.rb
```

### Loading Seeds

Load all seeds:

```bash
rails db:seed
```

Load specific category:

```bash
rails db:seed:algorithms:sorting
```

Reset and reload:

```bash
rails db:reset  # Drops, creates, migrates, and seeds
```

## Usage

### Accessing Algorithms

```ruby
# Get all sorting algorithms
sorting = AlgorithmCategory.find_by(name: 'Sorting Algorithms')
sorting_algorithms = sorting.algorithms

# Find specific algorithm
quick_sort = Algorithm.find_by(name: 'Quick Sort')

# Get complexity analysis
quick_sort.complexity_analysis

# Get implementations
quick_sort.implementations.by_language('ruby')

# Get examples
quick_sort.examples.by_difficulty(:beginner)
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/your-feature`)
3. Add your algorithms to the appropriate seed file
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin feature/your-feature`)
6. Create a Pull Request

## License

This project is licensed under the MIT License
