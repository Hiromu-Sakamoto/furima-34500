class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index,:create]
  before_action :set_item, only: [:index,:create]
  before_action :user_confirmation, only: [:index,:create]


  def index
    @orderform = OrderForm.new
  end

  def create
    @orderform = OrderForm.new(orderform_params)
    if @orderform.valid?
      pay_item
      @orderform.save
      redirect_to root_path
    else
      render 'orders/index'
    end
  end

  private

  def orderform_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :phone_number, :building_name).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item[:price],
      card: orderform_params[:token],
      currency: 'jpy'
    )
  end

  def user_confirmation
    if current_user == @item.user || @item.order.present?
      redirect_to item_path(@item)
    end
  end
end
