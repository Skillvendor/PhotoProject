json.array!(@pictures) do |pic|
  json.extract! pic, :id, :photo, :description, :category_id
end