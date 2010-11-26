module WhiteSpace
  class VM
    def self.run(insns)
      new(insns).run
    end

    def initialize(insns)
      @insns = insns
      @stack = []
      @heap = {}
      @labels = find_labels(@insns)
    end

    def run
      return_to = []
      pc = 0
      while pc < @insns.size
        insn, arg = *@insns[pc]

        case insn
        when :push
          push (arg)
        when :heap_write
          value, address = pop, pop
          @heap[address] = value
        # when
        # ...
        when :exit
          return
        end

        pc += 1
      end
      raise
    end

    private
    def find_labels(insns)
      labels = {}
      insns.each_with_index do |item, i|
        insn, arg = *item
        if insn == :label
          labels[arg] ||= i
        end
      end
      labels
    end

    def push(item)
      raise unless item.is_a?(Integer)
      @stack.push(item)
    end

    def pop
      item = @stack.pop
      raise if item.nil?
      item
    end

    def jump_to(name)
      pc = @labels[name]
      railse if pc.nil?
      pc
    end
  end
end
