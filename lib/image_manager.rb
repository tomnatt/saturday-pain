require './lib/flickr_api'
require './lib/photo'

class ImageManager
  @image_directory = 'images'
  @sat_pain_photoset_id = 72_157_711_613_641_123

  def self.download_images
    flickr_api = FlickrApi.new(ENV.fetch('FLICKR_USER_ID'), ENV.fetch('FLICKR_API_KEY'))
    ids = flickr_api.get_photo_ids_in_photoset(@sat_pain_photoset_id)

    # Turn all into metadata and download the image
    ids.each do |id|
      photo_metadata = flickr_api.get_photo_metadata(id)
      photo_metadata.save(@image_directory)

      photo_url = flickr_api.get_photo_url(id)
      File.write(File.join(@image_directory, "#{id}.jpg"), Net::HTTP.get(URI.parse(photo_url)))
    end
  end

  def self.delete_all
    FileList[File.join(@image_directory, '**', '*')].exclude('.keep').each { |f| File.delete(f) }
  end
end
