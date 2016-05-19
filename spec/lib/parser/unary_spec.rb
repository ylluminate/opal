require 'support/parser_helpers'

describe Opal::Parser do
  describe '-@' do
    context 'with an integer' do
      it "parses unary op. with the right precedence" do
        parsed("-1.hello").should == [:call, [:int, -1], :hello, [:arglist]]
        expected = [:call, [:call, [:int, 1], :**, [:arglist, [:int, 2]]], :-@, [:arglist]]
        parsed("-1 ** 2").should == expected
        expected = [:call, nil, :puts, [:arglist, [:call, [:int, -1], :hello, [:arglist]]]]
        parsed("puts -1.hello").should == expected
      end

      it "parses unary op. as a method call" do
        parsed("-1").should == [:int, -1]
      end

    end

    context 'with a float' do
      it "parses unary op. with the right precedence" do
        parsed("-1.23.hello").should == [:call, [:float, -1.23], :hello, [:arglist]]
      end

      it "parses unary op. as a method call" do
        parsed("-1.23").should == [:float, -1.23]
      end
    end
  end

  describe '+@' do
    context 'with an integer' do
      it "parses unary op. with the right precedence" do
        parsed("+1.hello").should == [:call, [:int, 1], :hello, [:arglist]]
      end

      it "parses unary op. as a method call" do
        parsed("-1").should == [:int, -1]
      end
    end

    context 'with a float' do
      it "parses unary op. with the right precedence" do
        parsed("+1.23.hello").should == [:call, [:float, 1.23], :hello, [:arglist]]
      end

      it "parses unary op. as a method call" do
        parsed("-1.23").should == [:float, -1.23]
      end
    end
  end
end
