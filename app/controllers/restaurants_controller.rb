class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def index
    puts current_user.id
    @restaurant_owner = RestaurantOwner.find(current_user.actable_id)
    @restaurants = @restaurant_owner.restaurants
  end

  def show

  end

  def new
  end

  def create

  end

  def edit
  end

  def update

  end

  def destroy

  end

end