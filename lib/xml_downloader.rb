class XmlDownloader
  require 'open-uri'

  def self.download(url)
    open(url)
  end
end
