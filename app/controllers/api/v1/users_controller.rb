class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!, only: [:destroy, :update]

  def index
    users = User.all
    render json: users, status: 200
  end

  def show
  end

  def create
    user = User.new(user_params)
    if user.save
      user.generate_authentication_token!
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = current_user
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: {errors: user.errors}, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

    private
      def user_params
        params.require(:user).permit(:email,:password, :password_confirmation, :login, :name, :surname)
      end
end
