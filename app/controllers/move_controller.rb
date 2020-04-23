class MoveController < ApplicationController

  def index
    @moves = Move.all.order(:name).limit(10)
  end

  def search
    keyword = params[:keyword]
    if keyword == ""
      @moves = Move.all.order(:name).limit(10)
    else
      @moves = Move.where(['name LIKE ? OR name LIKE ?', "%#{keyword.tr('ァ-ン','ぁ-ん')}%", "%#{keyword.tr('ぁ-ん','ァ-ン')}%"]).order(:name).limit(10)
    end
  end

  def result
    @target_move = params[:target_move]
    move_id = params[:move_id]
    @move = Move.find(move_id)
    @side = "left" if @target_move.include?("left")
    @side = "right" if @target_move.include?("right")
  end
end
