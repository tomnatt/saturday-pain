require 'json'
require 'net/http'
require 'uri'
require 'nokogiri'

user_id = ENV.fetch('FLICKR_USER_ID')
flickr_api_key = ENV.fetch('FLICKR_API_KEY')
photoset_id = 72_157_711_613_641_123

flickr_api = "https://api.flickr.com/services/rest/?&api_key=#{flickr_api_key}&user_id=#{user_id}"
flickr_get_photos = "#{flickr_api}&method=flickr.photosets.getPhotos&photoset_id=#{photoset_id}"

photos_xml = Net::HTTP.get(URI.parse(flickr_get_photos))
photos = Nokogiri::XML(photos_xml).xpath('//rsp/photoset/photo/@id')

puts photos

# For each picture, get information and populate object plus download image into a directory
flickr_get_photo = "#{flickr_api}&method=flickr.photos.getInfo"

photos.each do |photo_id|
  photo_xml = Net::HTTP.get(URI.parse("#{flickr_get_photo}&photo_id=#{photo_id}"))
  photo = Nokogiri::XML(photo_xml)

  title = photo.xpath('//photo/title')
  date = photo.xpath('//photo/dates/@taken')

  puts "#{title} taken #{date}"
end
