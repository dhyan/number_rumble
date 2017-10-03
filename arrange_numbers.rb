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
    @font = Gosu::Font.new(20)
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
      return if @stars.length > 100
      @stars.push(Star.new)
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    if @game.success?
      Star.new.draw
      @stars.each { |star| star.draw_stars }
    else
      @game.draw
    end
  end
end

window = ArrangeNumbers.new
window.show