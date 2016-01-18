# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)

  if invalid_triangle?([a, b, c])
    raise TriangleError
  end

  if(a == b && a == c)
    :equilateral
  elsif(a == b || a == c || b == c)
    :isosceles
  else
    :scalene
  end
end

def invalid_triangle?(sides)

  # Check for zero or negative sides
  sides.each do |side|
    return true if side <= 0
  end

  # Check each side is less than the sum of adjacent sides
  for i in sides
    if sides[0] >= sides[1] + sides[2]
      return true
    end
    sides.rotate!(1)
  end

  false
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
