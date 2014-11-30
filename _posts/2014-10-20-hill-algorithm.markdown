```ruby
class Array
  def sort_difference
    sorted = self.sort
    difference = []
    self.each_with_index do |e, i|
      difference << (e - sorted[i])
    end
    difference
  end

  def flip_signs
    a = []
    self.each do |e|
      a << e *(-1)
    end
    a
  end
end

a = [5, 4, 3, 2, 8] 

a.sort_difference.flip_signs
```
