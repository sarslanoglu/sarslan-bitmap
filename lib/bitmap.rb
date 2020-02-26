# frozen_string_literal: true

# Bitmap class for image related commands
class Bitmap
  def initialize(height, length)
    @image = Array.new(height) { Array.new(length, '0') }
    @height = height
    @length = length
  end

  # Command C
  # Command L
  # Command V
  # Command H
  # Command S
end
