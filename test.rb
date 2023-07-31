require 'flickr'
require 'json'

flickr = Flickr.new(ENV.fetch('FLICKR_API_KEY'), ENV.fetch('FLICKR_SHARED_SECRET'))

# list = flickr.galleries.getPhotos(gallery_id: '72157711613641123')
json_list = flickr.photosets.getPhotos(photoset_id: '72157711613641123')
# list = JSON.parse(json_list)
puts json_list
