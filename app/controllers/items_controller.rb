class ItemsController < ApplicationController
  def index
  end

  before_action :authenticate_user!
  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render "items/new"
    end
  end


  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :category_id, :condition_id, :charges_id, :prefecture_id, :estimated_date_id, :image).merge(user_id: current_user.id)
  end

end