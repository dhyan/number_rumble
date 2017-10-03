require_relative 'square'

class Game
  attr_reader :squares

  module ZOrder
    BACKGROUND, STARS, PLAYER, UI = *0..3
  end

  # Each number has a fixed unique position in the solved array
  RESULT = [[1,1,1], [1, 2, 2], [1, 3, 3], [1, 4, 4],
            [2, 1, 5], [2,2,6], [2,3,7], [2,4,8],
            [3,1,9], [3,2,10], [3,3,11], [3,4,12],
            [4,1,13], [4,2,14],[4,3,15], [4,4,""]]

  def initialize(window)
    @start = Time.now
    @window = window
    @squares = []
    @font = Gosu::Font.new(20)
    numbers = (1..15).to_a#.shuffle!
    (1..4).each do |row|
      (1..4).each do |column|
        num = numbers.delete(numbers.sample)
        @squares.push Square.new(@window, column, row, num)
      end
    end
  end

  def swap_squares(mouse_x, mouse_y)
    row = (mouse_y.to_i - 20)/100
    column = (mouse_x.to_i - 20)/100
    curr_sqr = @squares.select {|sqr| sqr.row == row && sqr.column == column}
    vacant_sqr = @squares.select {|sqr| sqr.number == ''}
    swap(curr_sqr, vacant_sqr)
  end

  # Swap row and column values of 2 numbers
  def swap(curr_sqr, vacant_sqr)
    return unless cant_swap?(curr_sqr, vacant_sqr)
    curr_sqr[0].row, vacant_sqr[0].row = vacant_sqr[0].row, curr_sqr[0].row
    curr_sqr[0].column, vacant_sqr[0].column = vacant_sqr[0].column, curr_sqr[0].column
  end

  # Check if 2 numbers can be swapped?
  def cant_swap?(curr_sqr, vacant_sqr)
    vacant_row, vacant_column = vacant_sqr[0].row, vacant_sqr[0].column
    curr_row, curr_column = curr_sqr[0].row, curr_sqr[0].column
    return true if ((curr_row == vacant_row && curr_column == vacant_column - 1) ||
        (curr_row == vacant_row && curr_column == vacant_column + 1) ||
        (curr_row == vacant_row + 1 && curr_column == vacant_column) ||
        (curr_row == vacant_row - 1 && curr_column == vacant_column) )
    false
  end

  # Sucees when it matches the final RESULT array
  def success?
    #return true
    current_array = @squares&.map {|num| [num.row, num.column, num.number]}
    (RESULT - current_array).empty?
  end

  def draw
    @squares.each do |square|
      square.draw
    end
    @font.draw("Time Ticks: #{(Time.now - @start)}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00) #unless @game.success?
  end
end