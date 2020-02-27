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

  def read_file
    file = File.open('bin/bitmap_editor_examples/show.txt')
    file.readlines.map(&:chomp)
  end

  def execute(command, arguments)
    case command
    when 'I'
      raise 'Bitmap already created' if @bitmap

      validate_command(command, arguments, 2)
      @bitmap = Bitmap.new(arguments[1].to_i, arguments[0].to_i)
    when 'C'
      raise "Without bitmap can't execute command" unless @bitmap

      validate_command(command, arguments, 0)
      @bitmap.clear
    when 'L'
      raise "Without bitmap can't execute command" unless @bitmap

      validate_command(command, arguments, 3)
      @bitmap.paint_pixel(*arguments)
    when 'V'
      raise "Without bitmap can't execute command" unless @bitmap

      validate_command(command, arguments, 4)
      @bitmap.paint_vertical(*arguments)
    when 'H'
      raise "Without bitmap can't execute command" unless @bitmap

      validate_command(command, arguments, 4)
      @bitmap.paint_horizontal(*arguments)
    when 'S'
      raise "Without bitmap can't execute command" unless @bitmap

      validate_command(command, arguments, 0)
      @bitmap.show
    else
      raise "Command #{command} is invalid"
    end
  end

  private

  def validate_command(command, arguments, number_of_arg)
    return unless arguments.size != number_of_arg

    raise ArgumentError, "Command #{command} is accepting #{number_of_arg} arguments."\
    " But input file send #{arguments.size} arguments"
  end
end
