class Star
  attr_reader :x, :y

  def initialize
    @animation = Gosu::Image.new("media/rubyguy.png", tileable: true)
  end

  module ZOrder
    BACKGROUND, STARS, PLAYER, UI = *0..3
  end

  def draw_stars
    img = Gosu::Image.new("media/smoke.png", tileable: true)
    @color = Gosu::Color::BLACK.dup
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
    @x = rand * 640
    @y = rand * 580
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
             ZOrder::STARS, 1, 1, @color, :add)
  end

  def draw
    @animation.draw(100,100,100)
  end
end