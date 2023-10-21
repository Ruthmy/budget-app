class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_icons, only: %i[new create]

  def new
    @category = Category.new
    @category.icon = @icons.first
  end

  def create
    @category = Category.new(category_params)
    @category.author_id = current_user.id

    if @category.save
      redirect_to root_path, notice: 'Category created successfully'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def set_icons
    @icons = %w[attach_money shopping_cart restaurant
                directions_bus sports_esports home_repair_service
                favorite school move_to_inbox]
  end
end
