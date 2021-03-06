class DishesController < FrontController
  def index
    @dishes = Dish.where(restaurant_owner_id: current_user.actable_id)
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dish }
    end
  end

  def new
    @dish = Dish.new
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def create
    @restaurant_owner = RestaurantOwner.find(current_user.actable_id)
    @dish = @restaurant_owner.dishes.create(dish_params)
    if @dish.save
      flash[:success] = "Dodano potrawę"
      redirect_to dishes_path
    else
      flash[:warning] = "Nie udało się dodać potrawy"
      render 'new'
    end
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update_attributes(dish_params)
      flash[:success] = "Dane zaktualizowane"
      redirect_to dishes_path
    else
      render 'edit'
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    if @dish.active
      @dish.active = false
    else
      @dish.active = true
    end
    if @dish.save
      flash[:success] = "Pomyślnie zmieniono"
      redirect_to dishes_path
    else
      flash[:warning] = "Nie udało się zmienić"
      redirect_to dishes_path
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :price, :description)
  end
end
