require 'yaml'

require './lib/flickr_api'

sat_pain_photoset_id = 72_157_711_613_641_123

flickr_api = FlickrApi.new(ENV.fetch('FLICKR_USER_ID'), ENV.fetch('FLICKR_API_KEY'))
ids = flickr_api.get_photo_ids_in_photoset(sat_pain_photoset_id)

# Turn all into metadata
ids.each_with_index do |id, i|
  break if i > 2

  photo = flickr_api.get_photo_metadata(id)

  # Save to file
  puts YAML.dump(photo)
end