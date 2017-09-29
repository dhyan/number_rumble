require 'gosu'
class Square
  attr_accessor :row, :column, :number, :color, :vacant

  def initialize(window, column, row, num)
    @@font ||= Gosu::Font.new(window, 'System', 72)
    @@window ||= window
    @row = row
    @column = column
    @number = num
    @number = '' if row == 4 && column == 4
  end

  def clear
    @number = 0
  end

  def set(number)
    @number = number
  end

  def draw
    if @number != 0
      x1 = 22 + @column * 100
      y1 = 22 + @row * 100
      x2 = x1 + 96
      y2 = y1
      x3 = x2
      y3 = y2 + 96
      x4 = x1
      y4 = y3
      c = Gosu::Color.argb(0xff_ff0000)
      @@window.draw_quad(x1,y1,c,x2,y2,c,x3,y3,c,x4,y4,c)
      x_center = x1 + 48
      x_text = x_center - @@font.text_width("#{@number}")/2
      y_text = y1 + 12
      @@font.draw("#{@number}",x_text, y_text, 1)
    end
  end

end


