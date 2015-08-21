class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.references :user, index: true, null: false
      t.references :picture, index: true, null: false

      t.timestamps
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :pictures
  end
end
