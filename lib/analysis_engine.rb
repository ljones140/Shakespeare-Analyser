require 'rexml/document'

class AnalysisEngine
include REXML

  def self.analyse(play_script_xml)
    script_document = Document.new(play_script_xml)
    speakers = []
    script_document.elements.each("PLAY/ACT/SCENE/SPEECH") do |speech|
      speech.elements.each do |element|
        speakers << element.text if element.name == "SPEAKER"
      end
    end
    speakers
  end

end
