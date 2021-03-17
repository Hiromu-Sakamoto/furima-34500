class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :user_confirmation, only: [:index]

  def index
    @orderform = OrderForm.new
    @item = Item.find(params[:item_id])
  end

  def create
    @orderform = OrderForm.new(orderform_params)
    @item = Item.find(params[:item_id])
    if @orderform.valid?
      pay_item
      @orderform.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render 'orders/index'
    end
  end

  private

  def orderform_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :phone_number, :building_name).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
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
    @item = Item.find(params[:item_id])
    redirect_to item_path(@item) unless current_user == @item.user
    redirect_to item_path(@item) if @item.order.present?
  end
end
