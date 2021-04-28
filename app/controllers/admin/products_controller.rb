class Admin::ProductsController < ApplicationController

  # USER_ID, PASSWORD =  ENV[USER_ID],  ENV[PASSWORD]
  http_basic_authenticate_with name: ENV["USER_ID"], password: ENV["PASSWORD"]
  # http_basic_authenticate_with name: "a", password: "b"
  # Require authentication only for edit and delete operation
  #  before_filter :authenticate #, :only => [ :edit, :delete ]

  def index
    @products = Product.order(id: :desc).all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render :new
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    redirect_to [:admin, :products], notice: 'Product deleted!'
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end

end
