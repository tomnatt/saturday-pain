require './lib/flickr_api'
require './lib/photo'

class ImageManager
  @image_directory = 'images'
  @sat_pain_photoset_id = 72_157_711_613_641_123

  def self.download_images
    flickr_api = FlickrApi.new(ENV.fetch('FLICKR_USER_ID'), ENV.fetch('FLICKR_API_KEY'))
    ids = flickr_api.get_photo_ids_in_photoset(@sat_pain_photoset_id)

    # Turn all into metadata
    ids.each_with_index do |id, i|
      break if i > 2

      photo = flickr_api.get_photo_metadata(id)
      photo.save(@image_directory)
    end
  end

  def self.delete_all
    FileList[File.join(@image_directory, '**', '*')].exclude('.keep').each { |f| File.delete(f) }
  end
end
