class CachePicturesCount < ActiveRecord::Migration
  def up
  	execute "update categories set pictures_count=(select count(*) from pictures where category_id=categories.id)"
  end

  def down
  end
end
