require 'ruby2d'
require_relative 'egg'
require_relative 'ladders'

initial_width = 640
initial_height = 480
set title: '小雞蛋上樓梯',
    width: initial_width,
    height: initial_height,
    resizable: true

background = Image.new('background.png', width: initial_width, height: initial_height, opacity: 0.8)

ladders = Ladders.generate_ladders(initial_width, initial_height)

egg = Egg.new(initial_width, initial_height, 'egg.png')

game_over = false

update do
  unless game_over
    clear
    background.draw

    ladders.each(&:draw)
    egg.draw
    egg.update(ladders)

    if egg.y < 50
      speed = rand(4..10)
      ladders.each { |ladder| ladder.move_down(speed) }
      egg.move_down(speed)
      Ladders.generate_new_ladder(ladders, initial_width)
    end

    Text.new("Climbed Stairs: #{egg.climbed_stairs}", x: 10, y: 10, size: 20, color: 'black')

    if egg.y > initial_height
      game_over = true
      image = Image.new('broken_egg.png', width: 100, height: 100, x: initial_width / 2 + 30, y: initial_height / 2 + 50)
      Text.new("Game Over", x: initial_width / 2 - 80, y: initial_height / 2 - 50, size: 30, color: 'red')
      Text.new("Climbed Stairs: #{egg.climbed_stairs}", x: initial_width / 2 - 100, y: initial_height / 2, size: 20, color: 'green')
      restart_button = Text.new("Restart", x: initial_width / 2 - 40, y: initial_height / 2 + 50, size: 20, color: 'blue')

      on :mouse_down do |event|
        if restart_button.contains?(event.x, event.y)
          game_over = false
          ladders = Ladders.generate_ladders(initial_width, initial_height)
          egg = Egg.new(initial_width, initial_height, 'egg.png')
        end
      end
    end
  end
end

on :key_down do |event|
  case event.key
  when 'space'
    egg.jump(ladders)
  when 'left'
    egg.move_left
  when 'right'
    egg.move_right
  end
end

on :key_up do |event|
  egg.release(ladders) if event.key == 'space'
end

show
