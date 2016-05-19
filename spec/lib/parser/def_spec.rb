require 'support/parser_helpers'

describe "The def keyword" do
  describe "for normal definitions" do
    it "should return s(:def)" do
      parsed("def a; end").should == [:def, nil, :a, [:args], [:block, [:nil]]]
    end

    it "adds s(:nil) on an empty body" do
      parsed("def foo; end").last.should == [:block, [:nil]]
    end
  end

  describe "for singleton definitions" do
    it "should return s(:def)" do
      parsed("def self.a; end").should == [:def, [:self], :a, [:args], [:block, [:nil]]]
    end

    it "adds s(:nil) on an empty body" do
      parsed("def self.foo; end").last.should == [:block, [:nil]]
    end
  end

  describe "with normal args" do
    it "should list all args" do
      parsed("def foo(a); end")[3].should == [:args, [:arg, :a]]
      parsed("def foo(a, b); end")[3].should == [:args, [:arg, :a], [:arg, :b]]
    end
  end

  describe "with opt args" do
    it "should list all opt args as well as block with each lasgn" do
      parsed("def foo(a = 1); end")[3].should == [:args, [:optarg, :a, [:int, 1]]]
      parsed("def foo(a = 1, b = 2); end")[3].should == [:args, [:optarg, :a, [:int, 1]], [:optarg, :b, [:int, 2]]]
    end

    it "parses norm arg after optarg" do
      parsed("def foo(a = 1, b); end")[3].should == [:args, [:optarg, :a, [:int, 1]], [:arg, :b]]
    end
  end

  describe "with rest args" do
    it "should list rest args in place as a symbol with '*' prefix" do
      parsed("def foo(*a); end")[3].should == [:args, [:restarg, :a]]
    end

    it "uses '*' as an arg name for rest args without a name" do
      parsed("def foo(*); end")[3].should == [:args, [:restarg]]
    end
  end

  describe "with block arg" do
    it "should list block argument" do
      parsed("def foo(&a); end")[3].should == [:args, [:blockarg, :a]]
    end
  end

  describe "with keyword args" do
    it "should list all required keyword args" do
      parsed("def foo(a:); end")[3].should == [:args, [:kwarg, :a]]
      parsed("def foo(a:, b:); end")[3].should == [:args, [:kwarg, :a], [:kwarg, :b]]
    end

    it "should list all optional keyword args" do
      parsed("def foo(a: 1); end")[3].should == [:args, [:kwoptarg, :a, [:int, 1]]]
      parsed("def foo(a: 1, b: 2); end")[3].should == [:args, [:kwoptarg, :a, [:int, 1]], [:kwoptarg, :b, [:int, 2]]]
    end

    it "should list any keyword rest arg" do
      parsed("def foo(**); end")[3].should == [:args, [:kwrestarg]]
      parsed("def foo(**bar); end")[3].should == [:args, [:kwrestarg, :bar]]
    end

    it "should parse combinations of keyword args" do
      parsed("def foo(a:, b: 1, **c); end")[3].should == [:args, [:kwarg, :a], [:kwoptarg, :b, [:int, 1]], [:kwrestarg, :c]]
    end

    it "should parse keywords without parens" do
      parsed("def foo a:; end")[3].should == [:args, [:kwarg, :a]]
      parsed("def foo a:, b:; end")[3].should == [:args, [:kwarg, :a], [:kwarg, :b]]
      parsed("def foo a: 1, b: 2; end")[3].should == [:args, [:kwoptarg, :a, [:int, 1]], [:kwoptarg, :b, [:int, 2]]]
    end
  end

  it "parses (a,b=1,*c,d,&blk) arguments" do
    expected = [:args, [:arg, :a], [:optarg, :b, [:int, 1]], [:restarg, :c], [:arg, :d], [:blockarg, :blk]]
    parsed("def m(a,b=1,*c,d,&blk); end")[3].should == expected
  end

  it "parses (a,b=1,c,&blk) arguments" do
    expected = [:args, [:arg, :a], [:optarg, :b, [:int, 1]], [:arg, :c], [:blockarg, :blk]]
    parsed("def m(a,b=1,c,&blk); end")[3].should == expected
  end

  it "parses (a,*b,c,&blk) arguments" do
    expected = [:args, [:arg, :a], [:restarg, :b], [:arg, :c], [:blockarg, :blk]]
    parsed("def m(a,*b,c,&blk); end")[3].should == expected
  end

  it "parses (a=1,*b,c,&blk) arguments" do
    expected = [:args, [:optarg, :a, [:int, 1]], [:restarg, :b], [:arg, :c], [:blockarg, :blk]]
    parsed("def m(a=1,*b,c,&blk); end")[3].should == expected
  end

  it "parses (*b,c,&blk) arguments" do
    expected = [:args, [:restarg, :b], [:arg, :c], [:blockarg, :blk]]
    parsed("def m(*b,c,&blk); end")[3].should == expected
  end
end
