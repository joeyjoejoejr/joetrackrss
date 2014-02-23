xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Joe Tracking"
    xml.description "Track Joe on the AT."
    xml.link "http://www.anything-joes.com/"
    xml.tag! "atom:link", href: "http://www.anything-joes.com/rss", rel: "self", type: "application/rss+xml"

    @tracks.each do |track|
      xml.item do
        xml.title "Update at #{Time.parse(track['createdAt']).localtime}"
        xml.link "http://www.anything-joes.com/#/track/#{track['objectId']}"
        xml.description track['update']
        xml.pubDate Time.parse(track['createdAt']).rfc822
        xml.guid "http://www.anything-joes.com/#/track/#{track['objectId']}"
      end
    end
  end
end
