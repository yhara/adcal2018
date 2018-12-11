require 'dxopal'
include DXOpal
Image.register(:enemy, "images/computer_typing_hayai.png")
C_ORANGE = [233, 115, 51]
FONT_HP = Font.new(18)

def draw_thick_box(x1, y1, x2, y2, color, thickness)
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

Window.load_resources do
  Window.bgcolor = C_BLACK
  enemy = Enemy.new

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

    draw_thick_box(260, 240, 380, 360, C_WHITE, 4)

    Window.draw_font(270, 370, "HP 20/20", FONT_HP, color: C_WHITE)

    commands = ["たたかう", "こうどう", "アイテム", "みのがす"]
    4.times do |i|
      x = 90 + i*120
      draw_thick_box(x, 400, x + 100, 440, C_ORANGE, 2)
      Window.draw_font(x + 3, 410, commands[i], Font.default, color: C_ORANGE)
    end
  end
end
