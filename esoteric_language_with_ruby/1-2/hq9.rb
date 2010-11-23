class HQ9Plus
  def initialize(src)
    @src = src
    @count = 0
  end

  def run
    @src.each_char do |char|
      case char
      when "H"
        hello
      when "Q"
        print_source
      when "9"
        print_99_bottles_of_beer
      when "+"
        inc
      end
    end
  end

  private
  def hello
    puts "hello, world!"
  end

  def print_source
    print @src
  end

  def print_99_bottles_of_beer
    require '../1-1/99'
  end

  def inc
    @count += 1
  end
end

if $0 == __FILE__
  hq9plus = HQ9Plus.new(ARGF.read)
  hq9plus.run
end
