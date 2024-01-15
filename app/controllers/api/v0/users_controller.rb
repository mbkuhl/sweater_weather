class Api::V0::UsersController < ApplicationController

  def create
    begin
    user = User.create!(user_params)
    render json: UserSerializer.new(user), status: 201
    rescue ActiveRecord::RecordInvalid => exception
      render json: ErrorSerializer.new(ErrorMessage.new(exception, 422)).error_json, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end