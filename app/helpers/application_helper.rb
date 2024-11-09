module ApplicationHelper
  def difficulty_badge_class(level)
    case level.to_s.downcase
    when 'beginner'
      'bg-green-100 text-green-800'
    when 'intermediate'
      'bg-blue-100 text-blue-800'
    when 'advanced'
      'bg-purple-100 text-purple-800'
    when 'expert'
      'bg-red-100 text-red-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end

  def complexity_badge_class(complexity)
    case complexity
    when /O\(1\)/, /O\(log n\)/
      'bg-green-100 text-green-800'
    when /O\(n\)/
      'bg-blue-100 text-blue-800'
    when /O\(n log n\)/
      'bg-yellow-100 text-yellow-800'
    when /O\(n\^2\)/, /O\(n\^3\)/
      'bg-red-100 text-red-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end
end
