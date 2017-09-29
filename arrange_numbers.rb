require 'gosu'
require 'rmagick'
require_relative 'game'
require_relative 'star'

class ArrangeNumbers < Gosu::Window

  WIDTH = 640
  HEIGHT = 580

  def initialize
    super WIDTH,HEIGHT,false
    self.caption = "Arrange numbers from 1 to 15"
    fill = Magick::TextureFill.new(Magick::ImageList.new("media/space.png"))
    background = Magick::Image.new(WIDTH, HEIGHT, fill)
    @background_image = Gosu::Image.new(background, :tileable => true)
    @star_anim = Gosu::Image.load_tiles("media/gem.png", 25, 25)
    @stars = Array.new
    @game = Game.new(self)
  end

  module ZOrder
    BACKGROUND, STARS, PLAYER, UI = *0..3
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      @game.swap_squares(mouse_x, mouse_y)
    end
  end

  def update
    if @game.success?
      @stars.push(Star.new(@star_anim))
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @stars.each { |star| star.draw }
    @game.draw
  end
end

window = ArrangeNumbers.new
window.show