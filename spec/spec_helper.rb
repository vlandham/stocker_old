require 'rspec'

# $:.unshift(File.join(File.dirname(__FILE__), "..", "bin"))
$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

include Stocker

RSpec.configure do |config|
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end

  def source_root
    File.join(File.dirname(__FILE__), 'fixtures')
  end

  def destination_root
    File.join(File.dirname(__FILE__), 'sandbox')
  end

  def data(name)
    File.read(File.join(File.dirname(__FILE__), 'data', name))
  end

  def fixture(name)
    File.read(File.join(File.dirname(__FILE__), 'fixtures', name))
  end

  alias :silence :capture
end


