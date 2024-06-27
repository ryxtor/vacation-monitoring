class ApplicationController < ActionController::API
  respond_to :json

  def authenticate_user!(options = {})
    if user_signed_in?
      super
    else
      render json: { error: 'You need to sign in or sign up before continuing.' }, status: :unauthorized
    end
  end
end
