require 'lib/spec_helper'
require 'opal/sprockets'

describe Opal::Sprockets do
  let(:env) { Sprockets::Environment.new }
  before { Opal.paths.each { |path| env.append_path path } }

  describe '.load_asset' do
    it 'loads the main asset' do
      code = described_class.load_asset('console', env)
      expect(code).to include('Opal.load("console");')
    end

    it 'marks as loaded "opal" plus all non opal assets' do
      code = described_class.load_asset('corelib/runtime', env)
      expect(code).to include('Opal.loaded(["opal","corelib/runtime"]);')
    end

    it 'returns an empty string if the asset is not found' do
      code = described_class.load_asset('foo', env)
      expect(code).to eq('')
    end
  end

  describe '.javascript_include_tag' do
    it 'works with trailing / in the prefix' do
      code = described_class.javascript_include_tag('corelib/runtime', prefix: '/', sprockets: env, debug: false)
      expect(code).to include('src="/corelib/runtime.')
      expect(code).not_to include('//')
    end
  end
end
