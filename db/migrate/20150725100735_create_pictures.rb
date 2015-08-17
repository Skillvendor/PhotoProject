class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :description
      t.references :category, index: true
      t.timestamps
    end
    add_foreign_key :pictures, :categories
  end
end
