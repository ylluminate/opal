class NilClass
  `def.$$meta = #{self}`

  def !
    true
  end

  def &(other)
    false
  end

  def |(other)
    `other !== false && other !== nil`
  end

  def ^(other)
    `other !== false && other !== nil`
  end

  def ==(other)
    `other === nil`
  end

  def dup
    raise TypeError, "can't dup #{self.class}"
  end

  def clone
    raise TypeError, "can't clone #{self.class}"
  end

  def inspect
    'nil'
  end

  def nil?
    true
  end

  def singleton_class
    NilClass
  end

  def to_a
    []
  end

  def to_h
    `Opal.hash()`
  end

  def to_i
    0
  end

  alias to_f to_i

  def to_s
    ''
  end

  def to_c
    Complex.new(0, 0)
  end

  def rationalize(*args)
    raise ArgumentError if args.length > 1
    Rational(0, 1)
  end

  def to_r
    Rational(0, 1)
  end

  def instance_variables
    []
  end
end

NIL = nil
