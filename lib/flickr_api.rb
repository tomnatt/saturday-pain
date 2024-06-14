require 'net/http'
require 'uri'
require 'nokogiri'

require './lib/photo'

class FlickrApi
  @api_url = nil

  def initialize(user_id, api_key)
    @api_url = "https://api.flickr.com/services/rest/?&api_key=#{api_key}&user_id=#{user_id}"
  end

  def get_photo_ids_in_photoset(photoset_id)
    flickr_get_photos = "#{@api_url}&method=flickr.photosets.getPhotos&photoset_id=#{photoset_id}"
    photos_xml = Net::HTTP.get(URI.parse(flickr_get_photos))
    Nokogiri::XML(photos_xml).xpath('//rsp/photoset/photo/@id')
  end

  def get_photo_metadata(photo_id)
    photo_xml = Net::HTTP.get(URI.parse("#{@api_url}&method=flickr.photos.getInfo&photo_id=#{photo_id}"))
    photo = Nokogiri::XML(photo_xml)

    Photo.new(photo.xpath('//photo/@id').first.content.to_i,
              photo.xpath('//photo/title').first.content,
              photo.xpath('//photo/dates/@taken').first.content)
  end

  def get_photo_url(photo_id)
    photo_xml = Net::HTTP.get(URI.parse("#{@api_url}&method=flickr.photos.getSizes&photo_id=#{photo_id}"))
    photo = Nokogiri::XML(photo_xml)
    photo.xpath('//sizes/size[@label="Large"]').first.xpath('@source').to_s
  end
end
