# -*- coding: utf-8 -*-
class Brainf_ck
  class ProgramError < StandardError; end

  def initialize(src)
    @tokens = src.chars.to_a # トークンは1文字区切りでOK
    @jumps = analyze_jumps(@tokens)
  end

  def run
    tape = []
    pc = 0  # program counter?
    cur = 0

    while pc < @tokens.size
      case @tokens[pc]
      when "+"
        tape[cur] ||= 0
        tape[cur] += 1
      when "-"
        tape[cur] ||= 0
        tape[cur] -= 1
      when ">"
        cur += 1
      when "<"
        cur -= 1
        if cur < 0
          raise ProgramError, "0じゃないですか"
        end
      when "."
        n = ( tape[cur] || 0 )
        puts n.chr
      when ","
        tape[cur] = $stdin.getc.ord
      when "["
        # ポインタが0のときは "]" までジャンプ
        if tape[cur] == 0
          pc = @jumps[pc]
        end
      when "]"
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
    starts = [] # stack
    tokens.each_with_index do |c, i|
      if c == "["
        starts.push(i)
      elsif c == "]"
        if starts.empty?
          raise ProgramError, "「]」が多すぎます"
        end
        to = i
        from = starts.pop
        jumps[from] = to
        jumps[to] = from
      end
    end

    unless starts.empty?
      raise ProgramError, "「[」が多すぎます"
    end

    jumps
  end
end

Brainf_ck.new(ARGF.read).run
