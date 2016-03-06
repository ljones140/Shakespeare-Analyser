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

  describe '#self.build_results' do

    it 'builds hash with characters and count of their lines' do
      expect(AnalysisEngine.build_results(xml_content)).to eq({
        "First Witch"  => 2,
        "Second Witch" => 2,
      })
    end

    context 'characted has lines in more than one speech block' do

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
        <SPEAKER>First Witch</SPEAKER>
        <LINE>When shall we three meet again</LINE>
      </SPEECH>
    </SCENE>
  </ACT>
</PLAY>
EOF
      end

      it 'sums characters lines so they are only in results hash once' do
        expect(AnalysisEngine.build_results(xml_content)).to eq({
          "First Witch"  => 3,
        })
      end

    end

    context 'script contains lines attributed to ALL' do
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
        <SPEAKER>ALL</SPEAKER>
        <LINE>When shall we three meet again</LINE>
      </SPEECH>
    </SCENE>
  </ACT>
</PLAY>
EOF
      end

      it 'ignores lines attributed to ALL' do
        expect(AnalysisEngine.build_results(xml_content)).to eq({
          "First Witch"  => 2,
        })
      end

    end
  end

end
