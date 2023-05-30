class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
    @order = Order.new
  end

  def new
    @car = Car.new
    authorize @car
  end

  def create
    @car = Car.new(cars_params)
    @car.user = current_user
    authorize @car
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
    redirect_to car_path(@car)
    if @car.update(car_params)
      redirect_to @car, notice: 'Car updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    authorize @car
    @car.destroy
    redirect_to cars_path
  end

  private

  def cars_params
    params.require(:car).permit(:brand, :model, :price, :user_id)
  end
end
