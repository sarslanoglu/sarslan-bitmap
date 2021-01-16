# frozen_string_literal: true

require_relative 'bitmap'

# BitmapEditor class for reading and executing file
class BitmapEditor
  def run
    read_file.each do |line|
      command, *arguments = line.split
      execute(command, arguments)
    end
  end

  def read_file
    file = File.open('bin/bitmap_editor_examples/show.txt')
    file.readlines.map(&:chomp)
  end

  def execute(command, arguments)
    case command
    when 'I'
      create_bitmap(command, arguments)
    when 'C'
      clear_bitmap(command, arguments)
    when 'L'
      paint_pixel_on_bitmap(command, arguments)
    when 'V'
      paint_vertical_on_bitmap(command, arguments)
    when 'H'
      paint_horizontal_on_bitmap(command, arguments)
    when 'S'
      show_bitmap_image(command, arguments)
    else
      raise "Command #{command} is invalid"
    end
  end

  private

  def create_bitmap(command, arguments)
    raise 'Bitmap already created' if @bitmap

    validate_command(command, arguments, 2)
    @bitmap = Bitmap.new(arguments[1].to_i, arguments[0].to_i)
  end

  def clear_bitmap(command, arguments)
    raise "Without bitmap can't execute command" unless @bitmap

    validate_command(command, arguments, 0)
    @bitmap.clear
  end

  def paint_pixel_on_bitmap(command, arguments)
    raise "Without bitmap can't execute command" unless @bitmap

    validate_command(command, arguments, 3)
    @bitmap.paint_pixel(*arguments)
  end

  def paint_vertical_on_bitmap(command, arguments)
    raise "Without bitmap can't execute command" unless @bitmap

    validate_command(command, arguments, 4)
    @bitmap.paint_vertical(*arguments)
  end

  def paint_horizontal_on_bitmap(command, arguments)
    raise "Without bitmap can't execute command" unless @bitmap

    validate_command(command, arguments, 4)
    @bitmap.paint_horizontal(*arguments)
  end

  def show_bitmap_image(command, arguments)
    raise "Without bitmap can't execute command" unless @bitmap

    validate_command(command, arguments, 0)
    @bitmap.show
  end

  def validate_command(command, arguments, number_of_arg)
    return unless arguments.size != number_of_arg

    raise ArgumentError, "Command #{command} is accepting #{number_of_arg} arguments."\
    " But input file send #{arguments.size} arguments"
  end
end
