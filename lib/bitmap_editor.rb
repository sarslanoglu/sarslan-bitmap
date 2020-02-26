# frozen_string_literal: true

require_relative 'bitmap'

# BitmapEditor class for reading and executing file
class BitmapEditor
  def run
    read_file.each do |line|
      command, *arguments = line.split(' ')
      execute(command, arguments)
    end
  end

  private

  def read_file
    file = File.open('bin/bitmap_editor_examples/show.txt')
    file.readlines.map(&:chomp)
  end

  def execute(command, arguments)
    case command
    when 'I'
      @bitmap = Bitmap.new(arguments[1].to_i, arguments[0].to_i)
      # Command I
    when 'C'
      # Command C
    when 'L'
      # Command L
    when 'V'
      # Command V
    when 'H'
      # Command H
    when 'S'
      # Command S
    else
      raise
    end
  end
end
