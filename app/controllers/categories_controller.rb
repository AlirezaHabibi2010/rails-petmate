class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    authorize @category
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      redirect_to category_path(@category), notice: "Category was successfully saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @category
  end

  def update
    @category.update(category_params)
    authorize @category

    if @category.save
      redirect_to category_path(@category), notice: "Category was successfully updated."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
