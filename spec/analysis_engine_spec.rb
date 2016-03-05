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
    </SCENE>
  </ACT>
</PLAY>
EOF
  end

  describe '#analyse' do

    it 'returns the speaker name' do
      expect(analysis_engine.analyse).to eq("First Witch")
    end

  end

end
