# frozen_string_literal: true

require_relative '../lib/bitmap_editor'

describe 'Bitmap Editor' do
  context '.read_file' do
    it 'should read file' do
      @buffer = StringIO.new('I 8 10')
      @filename = 'somefile.txt'
      @content = 'I 8 10'
      allow(File).to receive(:open).with(@filename, 'w').and_yield(@buffer)

      File.open(@filename, 'w') { |f| f.readlines.map(&:chomp) }

      expect(@buffer.string).to eq(@content)
    end
  end
end
