class AddPicturesCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :pictures_count, :integer, default: 0, null: false
  end
end
