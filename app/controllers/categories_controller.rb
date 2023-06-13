class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = policy_scope(Category)
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category

    if @category.pets.empty?
      @category.destroy
      redirect_to categories_path, notice: "Category was successfully deleted."
    else
      redirect_to categories_path, notice: "Failed to delete category, it is used by at least one pet."
    end
  end

  def show
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

  def set_category
    @category = Category.find(params[:id])
  end
end
