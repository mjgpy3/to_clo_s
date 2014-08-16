require './lib/to_clo_s.rb'

{
  Object => -> { Object.new },
  Symbol => -> { :some_symbol },
  'An Empty Hash' => -> { {} }
}.each do |things_name, thing_builder|

  describe things_name do
    let(:thing) { thing_builder.() }

    describe '#to_clo_s' do
      subject { thing.to_clo_s }

      it { is_expected.to eq(thing.inspect) }
    end

  end

end
