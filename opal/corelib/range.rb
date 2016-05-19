require 'corelib/enumerable'

class Range
  include Enumerable

  `def.$$is_range = true;`

  attr_reader :begin, :end

  def initialize(first, last, exclude = false)
    raise ArgumentError unless first <=> last

    @begin   = first
    @end     = last
    @exclude = exclude
  end

  def ==(other)
    %x{
      if (!other.$$is_range) {
        return false;
      }

      return self.exclude === other.exclude &&
             self.begin   ==  other.begin &&
             self.end     ==  other.end;
    }
  end

  def ===(value)
    include? value
  end

  def cover?(value)
    @begin <= value && (@exclude ? value < @end : value <= @end)
  end

  def each(&block)
    return enum_for :each unless block_given?

    %x{
      var i, limit;

      if (#@begin.$$is_number && #@end.$$is_number) {
        if (#@begin % 1 !== 0 || #@end % 1 !== 0) {
          #{raise TypeError, "can't iterate from Float"}
        }

        for (i = #@begin, limit = #@end + #{@exclude ? 0 : 1}; i < limit; i++) {
          block(i);
        }

        return self;
      }

      if (#@begin.$$is_string && #@end.$$is_string) {
        #{@begin.upto(@end, @exclude, &block)}
        return self;
      }
    }

    current = @begin
    last    = @end

    while current < last
      yield current

      current = current.succ
    end

    yield current if !@exclude && current == last

    self
  end

  def eql?(other)
    return false unless Range === other

    @exclude === other.exclude_end? &&
    @begin.eql?(other.begin) &&
    @end.eql?(other.end)
  end

  def exclude_end?
    @exclude
  end

  alias :first :begin

  alias :include? :cover?

  alias :last :end

  # FIXME: currently hardcoded to assume range holds numerics
  def max
    if block_given?
      super
    else
      `#@exclude ? #@end - 1 : #@end`
    end
  end

  alias :member? :cover?

  def min
    if block_given?
      super
    else
      @begin
    end
  end

  alias member? include?

  def size
    _begin = @begin
    _end   = @end
    _end  -= 1 if @exclude

    return nil unless Numeric === _begin && Numeric === _end
    return 0 if _end < _begin
    infinity = Float::INFINITY
    return infinity if infinity == _begin.abs || _end.abs == infinity

    (`Math.abs(_end - _begin) + 1`).to_i
  end

  def step(n = 1)
    raise NotImplementedError
  end

  def to_s
    `#{@begin.inspect} + (#@exclude ? '...' : '..') + #{@end.inspect}`
  end

  alias inspect to_s

  def marshal_load(args)
    @begin = args[:begin]
    @end = args[:end]
    @exclude = args[:excl]
  end
end
