class Photo
  attr_accessor :date_taken, :title, :photo_id

  def initialize(photo_id, title, date_taken)
    @photo_id = photo_id
    @title = title
    @date_taken = date_taken
  end

  def save(dir)
    # Save as photo_id.yml
    File.write(File.join(dir, "#{photo_id}.yml"), YAML.dump(self))
  end
end
