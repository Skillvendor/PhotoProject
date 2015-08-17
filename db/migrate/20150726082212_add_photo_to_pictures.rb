class AddPhotoToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :photo, :string
  end
end
