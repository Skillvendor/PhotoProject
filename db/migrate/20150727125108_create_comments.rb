class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.references :user, index: true
      t.references :picture, index: true

      t.timestamps
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :pictures
  end
end
