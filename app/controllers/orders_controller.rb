class OrdersController < ApplicationController
  def index
  #フォームオブジェクトのインスタンスを生成し、インスタンス変数に代入する
    @orderform = OrderForm.new
    @item = Item.find(params[:item_id])
  end

  def create
    @orderform = OrderForm.new(orderform_params)
    if @orderform.valid?
      @orderform.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render "orders/index"
    end
  end

  private
  def orderform_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :phone_number, :building_name).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
