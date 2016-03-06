require 'rexml/document'

class AnalysisEngine
include REXML

  def self.analyse(play_script_xml)
    script_document = Document.new(play_script_xml)
    speakers = {}
    script_document.elements.each("PLAY/ACT/SCENE/SPEECH") do |speech|
      name = speech.elements["SPEAKER"].text
      line_count = speech.elements.select{ |element| element.name["LINE"] }.count
      speakers.merge!(name => line_count)
    end
    speakers
  end



end
