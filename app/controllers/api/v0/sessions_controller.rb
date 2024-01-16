class Api::V0::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: UserSerializer.new(user), status: 200
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Email and/or password are incorrect", 401)).error_json, status: :unauthorized
    end
  end
end