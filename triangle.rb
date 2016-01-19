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

  for i in 1..sides.length

    next_rotation = sides.rotate(i)

    # Check for zero or negative side
    return true if next_rotation[0] <= 0

    # Check side is less than the sum of adjacent sides
    return true if next_rotation[0] >= next_rotation[1] + next_rotation[2]

  end
  
  false
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
