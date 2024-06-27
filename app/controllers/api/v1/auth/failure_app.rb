class Api::V1::Auth::FailureApp < Devise::FailureApp
  def respond
    if request_format == :json
      json_error_response
    else
      super
    end
  end

  def json_error_response
    self.status = 401
    self.content_type = 'application/json'
    self.response_body = { error: i18n_message }.to_json
  end
end