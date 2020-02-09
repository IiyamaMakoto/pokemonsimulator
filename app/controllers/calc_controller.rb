class CalcController < ApplicationController
  extend ActiveHash::Associations::ActiveRecordExtensions
  before_action :set_natures, :set_weathers

  def index
    @pokemon_left = Pokemon.find_by_name "ミミッキュ"
    @status_left = Status.new(@pokemon_left)
    @pokemon_right = Pokemon.find_by_name "ドリュウズ"
    @status_right = Status.new(@pokemon_right)
  end

  def set_left
    @pokemon_left = Pokemon.find(params[:id])
    @status_left = Status.new(@pokemon_left)
  end

  def set_right
    @pokemon_right = Pokemon.find(params[:id])
    @status_right = Status.new(@pokemon_right)
  end

  def search
    keyword = params[:keyword]
    return nil if keyword == ""
    @pokemons = Pokemon.where(['name LIKE ?', "%#{keyword.tr('ぁ-ん','ァ-ン')}%"]).order(:name)
    respond_to do |format|
      format.json
    end
  end

  private

  def set_natures
    @natures = Nature.all
  end

  def set_weathers
    @weathers = Weather.all
  end
end
