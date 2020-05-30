class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :update, :destroy]

  def index
    @dogs = Dog.all

    if params[:sort] == 'name'
      #SQL syntax is used here, replace ASC with DESC if you want reverse order 
      @dogs = @dogs.order('dogs.name DESC')
    end

    if params[:sort] == 'age'
      #SQL syntax is used here, replace ASC with DESC if you want reverse order 
      @dogs = @dogs.order('dogs.age DESC')
    end

    if params[:sort] == 'weight'
      #SQL syntax is used here, replace ASC with DESC if you want reverse order 
      @dogs = @dogs.order('dogs.weight DESC')
    end

    if params[:sort] == 'breed'
      #SQL syntax is used here, replace ASC with DESC if you want reverse order 
      @dogs = @dogs.order('dogs.breeds DESC')
    end

    render(
      json: @dogs,
      status: :ok
    )
  end

  def show
    if @dog
      render json: @dog, status: :ok
    else
      render json: { ok: false }, status: :not_found
    end
  end

  def create
    @dog = Dog.create(dog_params)

    if @dog.valid?
      Dog.add_breed(@dog)
      render json: @dog, status: :created
    else
      render json: {errors: @dog.errors.messages}, status: :bad_request
    end
  end

  def update
    if @dog.update(dog_params)
      Dog.add_breed(@dog)
      render json: @dog, status: :ok
    else
      render json: {errors: @dog.errors.messages}, status: :bad_request
    end
  end

  def destroy
    @dog.destroy
    render json: nil, status: :no_content
  end

  def search
    limit = params[:limit] || 10
    page = params[:page] || 1
    offset = ((page.to_i - 1) * limit.to_i) || 0
    .limit(limit).offset(offset)

    @dogs = Dog.search(params[:q])

    render json: @dogs, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_dog
    @dog = Dog.find_by(id: params[:id])
  end

  def dog_params
    params.permit(:name, :age, :weight, :breeds)
  end
end