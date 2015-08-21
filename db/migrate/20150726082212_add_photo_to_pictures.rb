class AddPhotoToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :photo, :string, null: false
  end
end
