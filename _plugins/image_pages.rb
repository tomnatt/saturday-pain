require './lib/image_manager'

module ImagePages
  class ImagePageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      # Load the YAML files into Photo objects
      photos = ImageManager.load_pictures

      # Generate the listing page

      # Generate the photo pages
      photos.each do |photo|
        new_page = ImagePage.new(site, Dir.pwd, 'sessions', photo)
        site.pages << new_page
      end
    end
  end

  class ImagePage < Jekyll::Page
    # An image page
    def initialize(site, base, dir, photo)
      @site = site
      @base = base
      @dir = dir
      @name = "#{photo.photo_id}.html" # name of the generated page

      process(@name)
      read_yaml(File.join(@base, '_layouts'), 'picture.html')

      data['image_title'] = photo.title
      data['image_date'] = photo.date_taken
      data['image_path'] = ImageManager.image_path(photo)
    end
  end

  # class ListingPage < Jekyll::Page
  #   # Listing all the images
  #   def initialize(site, base, dir, filename)
  #     @site = site
  #     @base = base
  #     @dir = dir
  #     @name = get_generated_pagename(filename) # name of the generated page

  #   end
  # end
end
