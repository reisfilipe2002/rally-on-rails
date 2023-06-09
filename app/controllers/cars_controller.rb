class CarsController < ApplicationController

  def index
    @cars = policy_scope(Car)
    if params[:query].present?
      @cars = Car.search_by_brand_and_model(params[:query]).where(sold: false)
    else
      @cars = Car.where(sold: false)
    end
  end

  def my_cars
    @cars = Car.where(user_id: current_user.id)
    authorize @cars
  end

  def show
    @car = Car.find(params[:id])
    authorize @car
  end

  def new
    @car = Car.new
    authorize @car
  end

  def create
    @car = Car.new(cars_params)
    authorize @car
    @car.user = current_user
    if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  def edit
    @car = Car.find(params[:id])
    authorize @car
  end

  def update
    @car = Car.find(params[:id])
    authorize @car
    @car.update(cars_params)
    if @car.update(cars_params)
      redirect_to @car, notice: 'Car updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    authorize @car
    @car.destroy
    redirect_to cars_path(current_user)
  end

  private

  def cars_params
    params.require(:car).permit(:brand, :model, :price, :user_id, :photo)
  end

end
