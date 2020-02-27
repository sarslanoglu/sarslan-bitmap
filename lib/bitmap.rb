# frozen_string_literal: true

# Bitmap class for image related commands
class Bitmap
  def initialize(height, length)
    @height = height
    @length = length
    @image = Array.new(height) { Array.new(length, '0') } if between_limits?
  end

  def clear
    @image.each do |line|
      line.map! { '0' }
    end
  end

  def paint_pixel(x_coor, y_coor, colour)
    @image[y_coor.to_i - 1][x_coor.to_i - 1] = colour if valid_pixel?(x_coor, y_coor)
  end

  def paint_vertical(x_coor, y1_coor, y2_coor, colour)
    return unless valid_pixel?(x_coor, y1_coor) && valid_pixel?(x_coor, y2_coor)

    (y1_coor.to_i..y2_coor.to_i).each do |i|
      @image[i - 1][x_coor.to_i - 1] = colour
    end
  end

  # Command H
  # Command S

  private

  def between_limits?
    if @height.to_i.between?(1, 250) && @length.to_i.between?(1, 250)
      true
    else
      validation_message = ''
      unless @height.to_i.between?(1, 250)
        validation_message += <<~HEREDOC
          Given row number of #{@height} is out of boundries. Please provide a number between 1 and 250.
        HEREDOC
      end
      unless @length.to_i.between?(1, 250)
        validation_message += <<~HEREDOC
          Given column number of #{@length} is out of boundries. Please provide a number between 1 and 250.
        HEREDOC
      end
      raise RangeError, validation_message
    end
  end

  def valid_pixel?(x_coor, y_coor)
    if x_coor.to_i.between?(1, @length) && y_coor.to_i.between?(1, @height)
      true
    else
      validation_message = ''
      unless x_coor.to_i.between?(1, @length)
        validation_message += <<~HEREDOC
          Given x coordinate of #{x_coor} is out of boundries. Please provide a number between 1 and #{@length}.
        HEREDOC
      end
      unless y_coor.to_i.between?(1, @height)
        validation_message += <<~HEREDOC
          Given y coordinate of #{y_coor} is out of boundries. Please provide a number between 1 and #{@height}.
        HEREDOC
      end
      raise ArgumentError, validation_message
    end
  end
end
