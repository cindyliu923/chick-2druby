class Ladders
  def self.generate_ladders(window_width, window_height)
    ladders = []
    for i in 0..9
      x_position = rand(window_width - 400) + 100
      ladder_width = rand(100..150)
      ladders << Ladder.new(x_position, window_height - (i * 60) - 40, ladder_width, 10)
    end
    ladders
  end

  def self.generate_new_ladder(ladders, window_width)
    x_position = rand(window_width - 400)
    ladder_width = rand(60..100)
    new_ladder = Ladder.new(x_position, ladders.first.y - 60, ladder_width, 10)
    ladders.unshift(new_ladder)
  end
end

class Ladder
  attr_reader :x, :y, :width, :height

 def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end

  # 繪製樓梯
  def draw
    Rectangle.new(x: @x, y: @y, width: @width, height: 10, color: 'brown')
  end

  # 將樓梯向下移動
  def move_down(speed)
    @y += speed
  end
end
