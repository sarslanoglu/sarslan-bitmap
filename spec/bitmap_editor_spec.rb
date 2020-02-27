# frozen_string_literal: true

require_relative '../lib/bitmap_editor'

describe 'Bitmap Editor' do
  context '.read_file' do
    it 'should read file' do
      bitmap_editor = BitmapEditor.new
      ready_file = bitmap_editor.read_file

      expect(ready_file[1]).to eq('L 1 3 A')
    end
  end

  context '.run' do
    it 'should run commands' do
      bitmap_editor = BitmapEditor.new
      execution = bitmap_editor.run

      # Dummy test. It will be check final image when whole commands are ready
      expect(execution[1]).to eq('L 1 3 A')
    end
  end

  context '.execute' do
    context 'I command' do
      it 'gets RuntimeError when bitmap is already created' do
        bitmap_editor = BitmapEditor.new
        bitmap_editor.execute('I', %w[3 3])
        expect { bitmap_editor.execute('I', %w[4 4]) }.to raise_error(RuntimeError,
                                                                      'Bitmap already created')
      end

      it 'gets ArgumentError when argument size is wrong' do
        bitmap_editor = BitmapEditor.new
        error_message = 'Command I is accepting 2 arguments. But input file send 3 arguments'
        expect { bitmap_editor.execute('I', %w[4 4 A]) }.to raise_error(ArgumentError,
                                                                        error_message)
      end

      it 'gets RangeError when arguments are outside of range' do
        bitmap_editor = BitmapEditor.new
        error_message = <<~HEREDOC
          Given row number of 254 is out of boundries. Please provide a number between 1 and 250.
        HEREDOC
        expect { bitmap_editor.execute('I', %w[4 254]) }.to raise_error(RangeError, error_message)
      end

      it 'gets successful with arguments in range' do
        bitmap_editor = BitmapEditor.new
        bitmap_editor.execute('I', %w[3 3])
        empty_bitmap = [%w[0 0 0], %w[0 0 0], %w[0 0 0]]
        image = bitmap_editor.instance_variable_get(:@bitmap).instance_variable_get(:@image)
        expect(image).to eq(empty_bitmap)
      end
    end

    context 'Any command except I' do
      it 'gets RuntimeError when bitmap is missing' do
        bitmap_editor = BitmapEditor.new
        error_message = "Without bitmap can't execute command"
        expect { bitmap_editor.execute('V', %w[2 3 6 W]) }.to raise_error(RuntimeError,
                                                                          error_message)
      end
    end

    context 'C command' do
      it 'gets ArgumentError when argument size is wrong' do
        bitmap_editor = BitmapEditor.new
        bitmap_editor.execute('I', %w[3 3])
        error_message = 'Command C is accepting 0 arguments. But input file send 1 arguments'
        expect { bitmap_editor.execute('C', %w[A]) }.to raise_error(ArgumentError, error_message)
      end

      it 'gets successful with arguments in range' do
        bitmap_editor = BitmapEditor.new
        bitmap_editor.execute('I', %w[4 3])
        bitmap_editor.execute('L', %w[2 3 A])
        empty_bitmap = [%w[0 0 0 0], %w[0 0 0 0], %w[0 0 0 0]]
        painted_bitmap = [%w[0 0 0 0], %w[0 0 0 0], %w[0 A 0 0]]
        expect(bitmap_editor.instance_variable_get(:@bitmap).instance_variable_get(:@image))
          .to eq(painted_bitmap)
        bitmap_editor.execute('C', [])
        expect(bitmap_editor.instance_variable_get(:@bitmap).instance_variable_get(:@image))
          .to eq(empty_bitmap)
      end
    end

    context 'L command' do
      it 'gets ArgumentError when argument size is wrong' do
        bitmap_editor = BitmapEditor.new
        bitmap_editor.execute('I', %w[3 3])
        error_message = 'Command L is accepting 3 arguments. But input file send 2 arguments'
        expect { bitmap_editor.execute('L', %w[1 3]) }.to raise_error(ArgumentError, error_message)
      end

      it 'gets successful with arguments in range' do
        bitmap_editor = BitmapEditor.new
        empty_bitmap = [%w[0 0 0 0], %w[0 0 0 0], %w[0 0 0 0]]
        bitmap_editor.execute('I', %w[4 3])
        image = bitmap_editor.instance_variable_get(:@bitmap).instance_variable_get(:@image)
        expect(image).to eq(empty_bitmap)
        painted_bitmap = [%w[0 0 0 0], %w[0 0 0 0], %w[0 A 0 0]]
        bitmap_editor.execute('L', %w[2 3 A])
        expect(image).to eq(painted_bitmap)
      end
    end

    context 'V command' do
      it 'gets ArgumentError when argument size is wrong' do
        bitmap_editor = BitmapEditor.new
        bitmap_editor.execute('I', %w[3 3])
        error_message = 'Command V is accepting 4 arguments. But input file send 3 arguments'
        expect { bitmap_editor.execute('V', %w[2 3 W]) }.to raise_error(ArgumentError,
                                                                        error_message)
      end

      it 'gets successful with arguments in range' do
        bitmap_editor = BitmapEditor.new
        empty_bitmap = [%w[0 0 0 0], %w[0 0 0 0], %w[0 0 0 0]]
        bitmap_editor.execute('I', %w[4 3])
        image = bitmap_editor.instance_variable_get(:@bitmap).instance_variable_get(:@image)
        expect(image).to eq(empty_bitmap)
        painted_bitmap = [%w[0 P 0 0], %w[0 P 0 0], %w[0 P 0 0]]
        bitmap_editor.execute('V', %w[2 1 3 P])
        expect(image).to eq(painted_bitmap)
      end
    end
  end
end
