class CalcController < ApplicationController
  extend ActiveHash::Associations::ActiveRecordExtensions
  before_action :set_natures, :set_weathers, :set_fields, :selectable_setting, except: :search

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

  def selectable_setting
    @iv_selectable = []
    @iv_selectable << 31
    for num in 0..30 do
      @iv_selectable << num
    end
    @ev_selectable = []
    @ev_selectable << 252
    for num in 0..251 do
      @ev_selectable << num
    end
  end

  def set_natures
    @natures = Nature.all
  end

  def set_weathers
    @weathers = Weather.all
  end

  def set_fields
    @fields = Field.all
  end
end
