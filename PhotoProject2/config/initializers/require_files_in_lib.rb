Dir[Rails.root + 'lib/modules/*.rb'].each do |file|
  require file
end