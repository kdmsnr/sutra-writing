class Counter
  def initialize(val)
    @value = val
  end

  def inc
    @value += 1
  end

  def value
    @value
  end
end

if $0 == __FILE__
  require 'rubygems'
  require 'rspec'

  describe Counter do
    before { @ct = Counter.new(2)  }

    it do
      @ct.value.should == 2
    end

    it do
      @ct.inc
      @ct.inc
      @ct.inc
      @ct.value.should == 5
    end
  end
end

