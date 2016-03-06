require 'spec_helper'
require 'analysis_engine'

describe AnalysisEngine do

  let(:analysis_engine) { described_class.new(xml_content) }

  let(:xml_content) do
    <<-EOF
<PLAY>
  <TITLE>The Tragedy of Macbeth</TITLE>
  <ACT>
    <TITLE>ACT I</TITLE>
    <SCENE>
      <TITLE>SCENE I. A desert place.</TITLE>
      <STAGEDIR>Thunder and lightning. Enter three Witches</STAGEDIR>
      <SPEECH>
        <SPEAKER>First Witch</SPEAKER>
        <LINE>When shall we three meet again</LINE>
        <LINE>In thunder, lightning, or in rain?</LINE>
      </SPEECH>
      <SPEECH>
        <SPEAKER>Second Witch</SPEAKER>
        <LINE>When shall we three meet again</LINE>
        <LINE>In thunder, lightning, or in rain?</LINE>
      </SPEECH>
    </SCENE>
  </ACT>
</PLAY>
EOF
  end

  describe '#build_results' do

    it 'returns the speakers names with line amount' do
      expect(AnalysisEngine.build_results(xml_content)).to eq({
        "First Witch"  => 2,
        "Second Witch" => 2,
      })
    end

  end

end
