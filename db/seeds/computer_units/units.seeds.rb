puts "Starting to seed unit data..."

ActiveRecord::Base.transaction do
  # Main Categories
  unit_categories = [
    {
      name: 'Storage Units',
      description: 'Data storage and file sizes',
      display_order: 1
    },
    {
      name: 'Memory & Processing',
      description: 'RAM usage and CPU speeds',
      display_order: 2
    },
    {
      name: 'Network',
      description: 'Network speeds and latency',
      display_order: 3
    },
    {
      name: 'Power',
      description: 'Power consumption metrics',
      display_order: 4
    },
    {
      name: 'Response Times',
      description: 'System and interface latency',
      display_order: 5
    }
  ]

  puts "Creating unit categories..."
  unit_categories.each do |attrs|
    category = UnitCategory.find_or_create_by!(name: attrs[:name]) do |c|
      c.description = attrs[:description]
      c.display_order = attrs[:display_order]
    end
    puts "Created category: #{category.name}"
  end

  # Storage Units
  storage_units = [
    { name: 'Byte', symbol: 'B', base_value: 1, display_order: 1 },
    { name: 'Kilobyte', symbol: 'KB', base_value: 1024, display_order: 2 },
    { name: 'Megabyte', symbol: 'MB', base_value: 1024**2, display_order: 3 },
    { name: 'Gigabyte', symbol: 'GB', base_value: 1024**3, display_order: 4 },
    { name: 'Terabyte', symbol: 'TB', base_value: 1024**4, display_order: 5 },
    { name: 'Petabyte', symbol: 'PB', base_value: 1024**5, display_order: 6 }
  ]

  puts "Creating storage units..."
  storage_category = UnitCategory.find_by!(name: 'Storage Units')
  storage_units.each do |unit_data|
    unit = Unit.find_or_create_by!(
      name: unit_data[:name],
      unit_category: storage_category
    ) do |u|
      u.symbol = unit_data[:symbol]
      u.base_value = unit_data[:base_value]
      u.display_order = unit_data[:display_order]
    end
    puts "Created unit: #{unit.name}"
  end

  # Unit Comparisons
  comparison_data = [
    {
      unit_name: 'Byte',
      comparisons: [
        {
          title: 'ASCII Character',
          value: 1.0,
          comparison_type: 'Technical',
          description: 'A single text character'
        },
        {
          title: 'Single Emoji',
          value: 4.0,
          comparison_type: 'Technical',
          description: 'A single emoji character'
        }
      ]
    },
    {
      unit_name: 'Kilobyte',
      comparisons: [
        {
          title: 'Text Document Page',
          value: 3.0,
          comparison_type: 'Real-life',
          description: 'A typical page of plain text'
        },
        {
          title: 'Favicon',
          value: 3.0,
          comparison_type: 'Technical',
          description: 'Website icon file'
        }
      ]
    },
    {
      unit_name: 'Megabyte',
      comparisons: [
        {
          title: 'PDF Report',
          value: 3.0,
          comparison_type: 'Real-life',
          description: 'Average PDF document with text and images'
        },
        {
          title: 'MP3 Minute',
          value: 1.0,
          comparison_type: 'Technical',
          description: 'One minute of MP3 audio at 128kbps'
        }
      ]
    }
  ]

  puts "Creating unit comparisons..."
  comparison_data.each do |group|
    unit = Unit.find_by!(name: group[:unit_name])
    group[:comparisons].each do |comp_data|
      comparison = UnitComparison.find_or_create_by!(
        unit: unit,
        title: comp_data[:title]
      ) do |c|
        c.value = comp_data[:value]
        c.comparison_type = comp_data[:comparison_type]
        c.description = comp_data[:description]
      end
      puts "Created comparison: #{comparison.title} for #{unit.name}"
    end
  end

  # Unit Conversions
  puts "Creating unit conversions..."
  Unit.order(:base_value).each_cons(2) do |smaller_unit, larger_unit|
    conversion = UnitConversion.find_or_create_by!(
      from_unit: smaller_unit,
      to_unit: larger_unit
    ) do |c|
      c.conversion_factor = 1.0/1024
      c.explanation = "1 #{larger_unit.symbol} = 1024 #{smaller_unit.symbol}"
    end
    puts "Created conversion: #{smaller_unit.symbol} to #{larger_unit.symbol}"
  end

  puts "Seed completed successfully!"
rescue ActiveRecord::RecordInvalid => e
  puts "Error during seeding: #{e.message}"
  raise ActiveRecord::Rollback
end
