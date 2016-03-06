require 'spec_helper'

describe PlayAnalyser do
  let(:result_hash) { { 'First Witch' => 1, 'Second Witch' => 2 } }
  let(:analysis_engine) { double(:analysis_engine, build_results: result_hash) }
  let(:xml) { '<SPEECH><SPEAKER>FOO</SPEAKER></SPEECH>' }
  let(:downloader) { double(:downloader, download: xml) }
  let(:play_analyser) { described_class.new(downloader: downloader, analysis_engine: analysis_engine) }

  describe '#analyse_play' do
    it 'calls downloader with correct url' do
      expect(downloader).to receive(:download).with('www.foo.com')
      play_analyser.analyse_play('www.foo.com')
    end

    it 'calls analysis engine with xml' do
      expect(analysis_engine).to receive(:build_results).with(xml)
      play_analyser.analyse_play('www.foo.com')
    end

    it 'prints the results to console' do
      expect { play_analyser.analyse_play('www.foo.com') }.to output("1 First Witch\n2 Second Witch\n").to_stdout
    end
  end
end
