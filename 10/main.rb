require 'dxopal'
include DXOpal
Image.register(:player, "images/heart.png")
Image.register(:enemy, "images/computer_typing_hayai.png")
C_ORANGE = [233, 115, 51]
FONT_HP = Font.new(18)
PLAYAREA = [260, 240, 380, 360]

def draw_thick_box(x1, y1, x2, y2, color, thickness)
  p [x1, y1, x2 ,y2] if thickness == 4
  Window.draw_box_fill(x1, y1, x2, y2, color)
  t = thickness
  Window.draw_box_fill(x1+t, y1+t, x2-t, y2-t, C_BLACK)
end

class Enemy < Sprite
  def initialize
    x = 250
    y = 10
    super(x, y, Image[:enemy])

    @phase = 0
  end

  def update
    @phase += 0.01
    self.x = 250 + Math.cos(@phase) * 50
  end
end

class Player < Sprite
  def initialize
    x = 300
    y = 300
    super(x, y, Image[:player])

    @min_x = PLAYAREA[0]
    @max_x = PLAYAREA[2] - self.image.width
    @min_y = PLAYAREA[1]
    @max_y = PLAYAREA[3] - self.image.height
  end

  def update
    self.x = (self.x + Input.x).clamp(@min_x, @max_x)
    self.y = (self.y + Input.y).clamp(@min_y, @max_y)
  end
end

Window.load_resources do
  Window.bgcolor = C_BLACK
  enemy = Enemy.new
  player = Player.new

  Window.loop do
    w = 80; h = 100
    2.times do |row|
      6.times do |col|
        x = 80 + col*w
        y = 20 + row*h
        Window.draw_box(x, y, x+w, y+h, C_GREEN)
      end
    end

    enemy.update
    enemy.draw
    draw_thick_box(PLAYAREA[0]-4, PLAYAREA[1]-4, PLAYAREA[2]+4, PLAYAREA[3]+4, C_WHITE, 4)
    player.update
    player.draw

    Window.draw_font(270, 370, "HP 20/20", FONT_HP, color: C_WHITE)

    commands = ["たたかう", "こうどう", "アイテム", "みのがす"]
    4.times do |i|
      x = 90 + i*120
      draw_thick_box(x, 400, x + 100, 440, C_ORANGE, 2)
      Window.draw_font(x + 3, 410, commands[i], Font.default, color: C_ORANGE)
    end
  end
end
