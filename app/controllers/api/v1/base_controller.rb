class Api::V1::BaseController < ApplicationController
  respond_to :json

  rescue_from Exception, with: :generic_exception
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private

  def record_not_found(error)
    respond_to do |format|
      format.json { render :json => {:error => error.message}, :status => 404 }
    end
  end

  def generic_exception(error)
    respond_to do |format|
      format.json { render :json => {:error => error.message}, :status => 500 }
    end
  end

  def signed_in_and_admin?
    unless user_signed_in?
      render json: { errors: { user: "not signed in" } }, status: :unauthorized
    else  
      render json: { errors: { admin: "not an admin" } }, status: :unauthorized unless current_user.admin
    end 
  end
end