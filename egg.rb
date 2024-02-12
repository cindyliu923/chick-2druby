class Egg
  attr_reader :x, :y

  def initialize(window_width, window_height, image_path)
    @width = 40
    @height = 50
    @x = window_width / 2
    @y = window_height - 30 - @height
    @image = Image.new(image_path, width: @width, height: @height)
    @jumping = false
    @jump_start_y = 0
    @window_width = window_width
    @window_height = window_height
    @climbed_stairs = 0
  end

  def move_down(speed)
    @y += speed
  end

  def move_up
    @y -= 4
  end

  def move_left
    @x -= 20 if @x > 100
  end

  def move_right
    @x += 20 if @x < @window_width - 100
  end

  def jump(ladders)
    return if @jumping
    @jumping = true
    @jump_start_y = @y
    @jump_distance = 60
    ladders.each do |ladder|
      if @x + @width / 2 >= ladder.x && @x + @width / 2 <= ladder.x + ladder.width && @y + @height >= ladder.y && @y + @height <= ladder.y + 10
        @y = ladder.y - @height
        @climbed_stairs += 1
        break
      end
    end
  end

  def release(ladders)
    ladders.each do |ladder|
      if @x + @width / 2 >= ladder.x && @x + @width / 2 <= ladder.x + ladder.width && @y + @height >= ladder.y && @y + @height <= ladder.y + 10
        @y = ladder.y - @height
        @jumping = false
        return
      end
    end
    @jumping = true
  end

  def update(ladders)
    if @jumping
      @y -= 4
      @jump_distance -= 4
      if @jump_distance <= 0
        @jumping = false
      end
    else
      if !on_ladder?(ladders) || !bottom_touching_ladder?(ladders)
        move_down(4)
      end
    end
  end

  def draw
    @image.draw(x: @x, y: @y)
  end

  def on_ladder?(ladders)
    ladders.each do |ladder|
      if @x + @width / 2 >= ladder.x && @x + @width / 2 <= ladder.x + ladder.width && @y >= ladder.y - @height && @y <= ladder.y
        return true
      end
    end
    false
  end

  def bottom_touching_ladder?(ladders)
    ladders.each do |ladder|
      if @x + @width / 2 >= ladder.x && @x + @width / 2 <= ladder.x + ladder.width && @y + @height >= ladder.y && @y + @height <= ladder.y + 10
        return true
      end
    end
    false
  end

  def climbed_stairs
    @climbed_stairs
  end
end
