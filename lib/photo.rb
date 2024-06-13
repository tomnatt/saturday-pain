class Photo
  attr_accessor :date_taken, :title, :photo_id

  def initialize(photo_id, title, date_taken)
    @photo_id = photo_id
    @title = title
    @date_taken = date_taken
  end
end
