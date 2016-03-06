class PlayAnalyser

  def initialize(downloader:, analysis_engine:)
    @downloader = downloader
    @analysis_engine = analysis_engine
  end

  def analyse_play(url)
    play_script_xml = download(url)
    result_hash = @analysis_engine.build_results(play_script_xml)
    print(result_hash)
  end

  private

  def print(result_hash)
    result_hash.each do | name, line_count |
      puts "#{line_count} #{name}"
    end
  end

  def download(url)
    @downloader.download(url)
  end
end


