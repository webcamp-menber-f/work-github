class Public::ItemsController < ApplicationController
   before_action :authenticate_customer!, only: [:show,:index]
   
 def index
  @goods_genres = GoodsGenre.all
  if params[:goods_genre_id].present?
    @goods_genre = GoodsGenre.find(params[:goods_genre_id])
    @items = @goods_genre.items.page(params[:page]).per(6)
    @items_count = @items.total_count
  else
    @items = Item.page(params[:page]).per(6)
    @items_count = Item.count
  end
 end

  def show
    @item = Item.find(params[:id])
    @cart = Cart
     @goods_genres = GoodsGenre.all
  end


  private
  def item_params
    params.require(:item).permit(:item_name, :item_ex, :image, :price, :goods_genre_id, :count)
  end

end
