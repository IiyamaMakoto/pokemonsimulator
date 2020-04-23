class MoveController < ApplicationController

  def index
    @moves = Move.all.order(:name)
  end

  def search
    keyword = params[:keyword]
    if keyword == ""
      @moves = Move.all.order(:name)
    else
      @moves = Move.where(['name LIKE ? OR name LIKE ?', "%#{keyword.tr('ァ-ン','ぁ-ん')}%", "%#{keyword.tr('ぁ-ん','ァ-ン')}%"]).order(:name)
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
