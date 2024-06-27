# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # # before_action :configure_sign_in_params, only: [:create]
  # respond_to :json

  # # GET /resource/sign_in
  # # def new
  # #   super
  # # end

  # # POST /resource/sign_in
  # # def create
  # #   super
  # # end

  # # DELETE /resource/sign_out
  # # def destroy
  # #   super
  # # end

  # # protected

  # # If you have extra params to permit, append them to the sanitizer.
  # # def configure_sign_in_params
  # #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # # end

  # private

  # def respond_with(resource, _opts = {})
  #   render json: { token: current_token, user: resource }, status: :ok
  # end

  # def respond_to_on_destroy
  #   head :no_content
  # end

  # def current_token
  #   request.env['warden-jwt_auth.token']
  # end

  # def verify_signed_out_user
  #   head :no_content
  # end

  respond_to :json

  private

  def respond_with(resource, _opt = {})
    @token = request.env['warden-jwt_auth.token']
    headers['Authorization'] = @token

    render json: {
      status: {
        code: 200, message: 'Logged in successfully.',
        token: @token,
        data: {
          user: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
                               Rails.application.credentials.devise_jwt_secret_key!).first

      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
