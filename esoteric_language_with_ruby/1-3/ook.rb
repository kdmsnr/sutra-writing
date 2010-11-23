# -*- coding: utf-8 -*-
class Ook
  class ProgramError < StandardError; end

  def initialize(src)
    @tokens = src.scan(/Ook[\.\?!] Ook[\?\!\.]/)
    @jumps = analyze_jumps(@tokens)
  end

  def run
    tape = []
    pc = 0
    cur = 0

    while pc < @tokens.size
      case @tokens[pc]
      when "Ook. Ook."
        tape[cur] ||= 0
        tape[cur] += 1
      when "Ook! Ook!"
        tape[cur] ||= 0
        tape[cur] -= 1
      when "Ook. Ook?"
        cur += 1
      when "Ook? Ook."
        cur -= 1
        if cur < 0
          raise ProgramError
        end
      when "Ook! Ook."
        n = ( tape[cur] || 0 )
        puts n.chr
      when "Ook. Ook!"
        tape[cur] = $stdin.getc.ord
      when "Ook! Ook?"
        if tape[cur] == 0
          pc = @jumps[pc]
        end
      when "Ook? Ook!"
        if tape[cur] != 0
          pc = @jumps[pc]
        end
      end
      pc += 1
    end
  end

  private
  def analyze_jumps(tokens)
    jumps = {}
    starts = []
    tokens.each_with_index do |c, i|
      if c == "Ook! Ook?"
        starts.push(i)
      elsif c == "Ook? Ook!"
        if starts.empty?
          raise ProgramError
        end
        to = i
        from = starts.pop
        jumps[from] = to
        jumps[to] = from
      end
    end

    unless starts.empty?
      raise ProgramError
    end

    jumps
  end
end

Ook.new(ARGF.read).run
