# frozen_string_literal: true

require_relative '../lib/bitmap'
require 'awesome_print'

describe 'Bitmap' do
  context '.initialize' do
    it 'creates a new bitmap with white' do
      bitmap = Bitmap.new(3, 2)

      (0..2).each do |i|
        expect(bitmap.instance_variable_get(:@image)[i][0]).to eq('0')
        expect(bitmap.instance_variable_get(:@image)[i][1]).to eq('0')
      end
    end
  end
end
