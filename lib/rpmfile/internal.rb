module RPM
  class File
    module Internal
      # Internal: Read tag via rpm binary.
      #
      # Examples
      #
      #   read_tag('NAME')
      #   # => "glibc"
      #
      #   read_tag('VERSION')
      #   # => "2.18"
      #
      #   read_tag('RELEASE')
      #   # => "13.fc20"
      #
      # Returns tag content as String.
      def read_tag(tag)
        process = ChildProcess.build('rpm', '-qp', "--queryformat=%{#{ tag }}", file)
        process.environment['LANG'] = 'C'
        process.io.stdout = Tempfile.new('child-output')
        process.start
        process.wait
        process.io.stdout.rewind
        content = process.io.stdout.read
        process.io.stdout.close
        process.io.stdout.unlink
        content = nil if content == '(none)'
        content = nil if content == ''
        content
      end

    end
  end
end
