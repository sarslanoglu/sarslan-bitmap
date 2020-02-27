# frozen_string_literal: true

require_relative '../lib/bitmap'
require 'awesome_print'

describe 'Bitmap' do
  context '.initialize' do
    it 'gives error if allowed height size is passed' do
      error_message = <<~HEREDOC
        Given row number of 300 is out of boundries. Please provide a number between 1 and 250.
      HEREDOC
      expect { Bitmap.new(300, 2) }.to raise_error(RangeError, error_message)
    end

    it 'gives error if allowed length size is passed' do
      error_message = <<~HEREDOC
        Given column number of 260 is out of boundries. Please provide a number between 1 and 250.
      HEREDOC
      expect { Bitmap.new(2, 260) }.to raise_error(RangeError, error_message)
    end

    it 'gives error if allowed height and length sizes are passed' do
      row_error_message = <<~HEREDOC
        Given row number of 290 is out of boundries. Please provide a number between 1 and 250.
      HEREDOC
      column_error_message = <<~HEREDOC
        Given column number of 260 is out of boundries. Please provide a number between 1 and 250.
      HEREDOC
      full_error_message = row_error_message + column_error_message
      expect { Bitmap.new(290, 260) }.to raise_error(RangeError, full_error_message)
    end

    it 'creates a new bitmap with white' do
      bitmap = Bitmap.new(3, 2)

      (0..2).each do |i|
        expect(bitmap.instance_variable_get(:@image)[i][0]).to eq('0')
        expect(bitmap.instance_variable_get(:@image)[i][1]).to eq('0')
      end
    end
  end

  context '.clear' do
    it 'resets bitmap' do
      bitmap = Bitmap.new(3, 2)
      bitmap.instance_variable_get(:@image)[0][0] = 'S'
      clear_bitmap = [%w[0 0], %w[0 0], %w[0 0]]
      painted_bitmap = [%w[S 0], %w[0 0], %w[0 0]]
      expect(bitmap.instance_variable_get(:@image)).to eq(painted_bitmap)
      bitmap.clear
      expect(bitmap.instance_variable_get(:@image)).to eq(clear_bitmap)
    end
  end

  context '.paint_pixel' do
    it 'gives error if allowed x coordinate is passed' do
      bitmap = Bitmap.new(3, 2)
      error_message = <<~HEREDOC
        Given x coordinate of 10 is out of boundries. Please provide a number between 1 and 2.
      HEREDOC
      expect { bitmap.paint_pixel(10, 2, 'S') }.to raise_error(ArgumentError, error_message)
    end

    it 'gives error if allowed y coordinate is passed' do
      bitmap = Bitmap.new(3, 2)
      error_message = <<~HEREDOC
        Given y coordinate of 12 is out of boundries. Please provide a number between 1 and 3.
      HEREDOC
      expect { bitmap.paint_pixel(2, 12, 'S') }.to raise_error(ArgumentError, error_message)
    end

    it 'gives error if allowed x and y coordinates are passed' do
      bitmap = Bitmap.new(3, 2)
      row_error_message = <<~HEREDOC
        Given x coordinate of 12 is out of boundries. Please provide a number between 1 and 2.
      HEREDOC
      column_error_message = <<~HEREDOC
        Given y coordinate of 12 is out of boundries. Please provide a number between 1 and 3.
      HEREDOC
      full_error_message = row_error_message + column_error_message
      expect { bitmap.paint_pixel(12, 12, 'S') }.to raise_error(ArgumentError, full_error_message)
    end

    it 'paints one pixel on bitmap' do
      bitmap = Bitmap.new(3, 2)
      clear_bitmap = [%w[0 0], %w[0 0], %w[0 0]]
      expect(bitmap.instance_variable_get(:@image)).to eq(clear_bitmap)
      bitmap.paint_pixel(1, 1, 'B')
      painted_bitmap = [%w[B 0], %w[0 0], %w[0 0]]
      expect(bitmap.instance_variable_get(:@image)).to eq(painted_bitmap)
    end
  end
end
