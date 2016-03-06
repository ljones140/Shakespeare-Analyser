require 'rexml/document'

class AnalysisEngine
include REXML

  def self.build_results(play_script_xml)
    self.new(play_script_xml).send(:analyse)
  end

  private

  def analyse
    @script_document.elements.each("PLAY/ACT/SCENE/SPEECH") do |speech|
      name = speech.elements["SPEAKER"].text
      line_count = speech.elements.select{ |element| element.name["LINE"] }.count
      @results.merge!(name => line_count)
    end
    @results
  end

  def initialize(play_script_xml)
    @script_document = Document.new(play_script_xml)
    @results = {}
  end
end
