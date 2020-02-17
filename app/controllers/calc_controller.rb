class CalcController < ApplicationController
  extend ActiveHash::Associations::ActiveRecordExtensions
  before_action :set_natures, :set_items, :set_weathers, :set_fields, :selectable_setting, except: :search

  def index
    @pokemon_left = Pokemon.find_by_name "ミミッキュ"
    @status_left = Status.new(@pokemon_left)
    @abilities_left = @pokemon_left.abilities
    @pokemon_right = Pokemon.find_by_name "ドリュウズ"
    @status_right = Status.new(@pokemon_right)
    @abilities_right = @pokemon_right.abilities
  end

  def search
    keyword = params[:keyword]
    return nil if keyword == ""
    @pokemons = Pokemon.where(['name LIKE ?', "%#{keyword.tr('ぁ-ん','ァ-ン')}%"]).order(:name)
    respond_to do |format|
      format.json
    end
  end

  def result
    keyword = params[:keyword]
    @pokemon = Pokemon.find_by(name: keyword)
    respond_to do |format|
      format.json
    end
  end

  private

  def status_params
    params.permit(:level_left, :hp_iv, :hp_ev, :attack_iv, :attack_ev, :defence_iv, :defence_ev, :sp_atk_iv, :sp_atk_ev, :sp_def_iv, :sp_def_ev, :speed_iv, :speed_ev)
  end

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

  def set_items
    @items = Item.all
  end

  def set_weathers
    @weathers = Weather.all
  end

  def set_fields
    @fields = Field.all
  end

end
