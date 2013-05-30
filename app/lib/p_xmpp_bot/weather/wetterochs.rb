require 'rss'
require 'open-uri'
require 'sanitize'

class Wetterochs

    WETTEROCHS_RSS_RUL = 'http://wmdata.wettermail.de/wetter/current/wettermail.rss';

    def getCurrentMail
        open(WETTEROCHS_RSS_RUL) do |rss|
            feed = RSS::Parser.parse(rss)
            feed.items.each do |item|
                return Sanitize.clean(item.description)
            end
        end
    end
end