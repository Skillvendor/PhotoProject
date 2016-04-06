module CategoriesHelper

  def current_url(new_params)
    url_for params.merge(new_params)
  end
end
