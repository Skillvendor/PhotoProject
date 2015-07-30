class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :render_single_page


   def render_single_page
    render 'layouts/application' if request.format == Mime::HTML
  end
end
