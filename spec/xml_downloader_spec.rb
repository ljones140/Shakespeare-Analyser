require 'spec_helper'
require 'xml_downloader'

describe XmlDownloader do

  let(:url) { "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml" }

  it 'calls open uri with xml url' do
    expect(XmlDownloader).to receive(:open).with(url)
    XmlDownloader.download(url)
  end

end
