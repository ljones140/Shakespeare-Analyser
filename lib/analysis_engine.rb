class AnalysisEngine
  require 'rexml/document'
  include REXML

  def self.build_results(play_script_xml)
    new(play_script_xml).send(:analyse)
  end

  private

  def initialize(play_script_xml)
    @script_document = Document.new(play_script_xml)
    @results = {}
  end

  def analyse
    calculate_lines_per_character
    @results
  end

  def calculate_lines_per_character
    @script_document.elements.each('PLAY/ACT/SCENE/SPEECH') do |speech|
      add_to_results(name(speech), line_count(speech)) if name(speech) != 'ALL'
    end
  end

  def name(speech)
    speech.elements['SPEAKER'].text
  end

  def line_count(speech)
    speech.elements.count { |element| element.name['LINE'] }
  end

  def add_to_results(name, num_lines)
    @results.key?(name) ? @results[name] += num_lines : @results.merge!(name => num_lines)
  end
end
