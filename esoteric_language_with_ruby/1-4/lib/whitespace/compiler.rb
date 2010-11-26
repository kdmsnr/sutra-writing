module WhiteSpace
  class Compiler
    class ProgramError < StandardError; end

    NUM = /([ \t]+)\n/
    LABEL = NUM

    def self.compile(src)
      new(src).compile
    end

    def initialize(src)
      @src = src
      @s = nil
    end

    def compile
      @s = StringScanner.new(bleach(@src))
      insns = [] # instructions
      until @s.eos?
        insns.push(step)
      end
      insns
    end

    private
    def step
      case
      when @s.scan(/ #{NUM}/) then [:push, num(@s[1])]
      when @s.scan(/ \n /)    then [:dup]
        # ...
      end
    end

    def num(str)
      raise ArgumentError if str !~ /\A[ \t]+\z/

      num =
        str.sub(/\A /, "+").
        sub(/\A\t/, "-").
        sub(/ /, "0").
        gsub(/\t/, "1")
      num.to_i(2)
    end

    def label(str)
      str
    end

    def bleach(src)
      src.gsub(/[^ \t\n]/, "")
    end
  end
end
