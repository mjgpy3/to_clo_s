require './lib/to_clo_s.rb'
require 'set'

{
  Object => -> { Object.new },
  Symbol => -> { :some_symbol },
  'An empty hash' => -> { {} },
}.each do |things_name, thing_builder|

  describe things_name do
    let(:thing) { thing_builder.() }

    describe '#to_clo_s' do
      subject { thing.to_clo_s }

      it { is_expected.to eq(thing.inspect) }
    end

  end

end

describe Hash do

  describe '#to_clo_s' do
    subject { hash.to_clo_s }

    context 'when multiple associations' do
      let(:hash) { { foo: :bar, spam: :eggs } }

      it { is_expected.to eq('{:foo :bar :spam :eggs}') }
    end

    context 'when a single association' do
      let(:hash) { { foo: :bar } }

      it { is_expected.to_not include('=>') }
      it { is_expected.to include(' ') }

      context 'and a key or value is an empty hash' do
        let(:hash) { { {} => :val } }

        it { is_expected.to eq('{{} :val}') }
      end

      context 'and a key or value is a hash with a key-value pair' do
        let(:hash) { { { foo: :bar } => :val } }

        it { is_expected.to eq('{{:foo :bar} :val}') }
      end

      context 'and a key or value is a string that contains the rocket symbol' do
        let(:hash) { { '=>' => 'val' } }

        it { is_expected.to eq('{"=>" "val"}') }
      end

    end

  end

end

describe NilClass do

  describe '#to_clo_s' do
    subject { nil.to_clo_s }

    it { is_expected.to eq('nil') }
  end

end

describe Array do

  describe '#to_clo_s' do
    subject { array.to_clo_s }

    context 'when empty' do
      let(:array) { [] }

      it { is_expected.to eq('[]') }
    end

    context 'when containing a simple primitive' do
      let(:array) { [42] }

      it { is_expected.to eq('[42]') }
    end

    context 'when containing an empty hash' do
      let(:array) { [{}] }

      it { is_expected.to eq('[{}]') }
    end

    context 'when containing a hash with an association' do
      let(:array) { [{ foo: :bar }] }

      it { is_expected.to eq('[{:foo :bar}]') }
    end

    context 'when containing multiple hashes with multiple associations' do
      let(:array) { [{ foo: :bar, spam: :eggs }, { 42 => :answer, "what is?" => :the_question}] }

      it { is_expected.to eq('[{:foo :bar :spam :eggs} {42 :answer "what is?" :the_question}]') }
    end

  end

end

describe Set do

  describe '#to_clo_s' do
    subject { array.to_set.to_clo_s }

    context 'when empty' do
      let(:array) { [] }

      it { is_expected.to eq('#{}') }
    end

    context 'when containing multiple elements' do
      let(:array) { [:foobar, { spam: :eggs } ] }

      it { is_expected.to eq('#{:foobar {:spam :eggs}}') }
    end

    context 'when containing one element' do
      let(:array) { [element] }

      context 'which is a hash with an association' do
        let(:element) { { foo: :bar } }

        it { is_expected.to eq('#{{:foo :bar}}') }
      end

      context 'which is numeric' do
        let(:element) { 42 }

        it { is_expected.to eq('#{42}') }
      end

    end

  end

end
