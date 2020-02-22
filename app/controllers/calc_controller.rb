class CalcController < ApplicationController
  include ApplicationHelper
  include CalcHelper
  extend ActiveHash::Associations::ActiveRecordExtensions
  before_action :set_natures, :set_items, :set_weathers, :set_fields, :selectable_setting, except: :search

  def index
    @pokemon_left = Pokemon.find_by_name "ミミッキュ"
    @status_left = Status.new(@pokemon_left)
    @abilities_left = @pokemon_left.abilities
    @pokemon_right = Pokemon.find_by_name "ドリュウズ"
    @status_right = Status.new(@pokemon_right)
    @abilities_right = @pokemon_right.abilities
    @hp_left = @status_left.hp_value
    @hp_right = @status_right.hp_value
    @hp_remain_left = @hp_left
    @hp_remain_right = @hp_right
    @hp_remain_left_max = @hp_left
    @hp_remain_right_max = @hp_right
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

  def damage
    current_status_setting
    @power_left = @move_left.power * power_correction
    @power_right = @move_right.power * power_correction
    @hp_left = @hp_value_left * hp_correction
    @hp_right = @hp_value_right * hp_correction
    if @move_left.category == "物理"
      @attack_left = @attack_value_left * attack_correction
      @defence_right = @defence_value_right * defence_correction
    elsif @move_left.category == "特殊"
      @attack_left = @sp_atk_value_left * sp_atk_correction
      @defence_right = @sp_def_value_right * sp_def_correction
    end
    @damage_left_to_right = (((@level_left * 2 / 5 + 2).floor * @power_left * @attack_left / @defence_right).floor / 50 + 2).floor
    @damage_left_to_right = (@damage_left_to_right * damage_correction).floor
    @damage_left_to_right_min = (@damage_left_to_right * 0.85).floor
    @damage_left_to_right *= 1.5 if @pokemon_left.types.ids.include?(@move_left.type_id)
    @damage_left_to_right_min *= 1.5 if @pokemon_left.types.ids.include?(@move_left.type_id)
    @damage_left_to_right = (@damage_left_to_right * type_correction(@move_left.type_id, @pokemon_right.types[0].id)).floor if @pokemon_right.types[0].present?
    @damage_left_to_right = (@damage_left_to_right * type_correction(@move_left.type_id, @pokemon_right.types[1].id)).floor if @pokemon_right.types[1].present?
    @damage_left_to_right_min = (@damage_left_to_right_min * type_correction(@move_left.type_id, @pokemon_right.types[0].id)).floor if @pokemon_right.types[0].present?
    @damage_left_to_right_min = (@damage_left_to_right_min * type_correction(@move_left.type_id, @pokemon_right.types[1].id)).floor if @pokemon_right.types[1].present?
    @hp_remain_right = @hp_right - @damage_left_to_right
    @hp_remain_right_max = @hp_right - @damage_left_to_right_min
    if @move_right.category == "物理"
      @attack_right = @attack_value_right * attack_correction
      @defence_left = @defence_value_left * defence_correction
    elsif @move_right.category == "特殊"
      @attack_right = @sp_atk_value_right * sp_atk_correction
      @defence_left = @sp_def_value_left * sp_def_correction
    end
    @damage_right_to_left = (((@level_right * 2 / 5 + 2).floor * @power_right * @attack_right / @defence_left).floor / 50 + 2).floor
    @damage_right_to_left = (@damage_right_to_left * damage_correction).floor
    @damage_right_to_left_min = (@damage_right_to_left * 0.85).floor
    @damage_right_to_left *= 1.5 if @pokemon_right.types.ids.include?(@move_right.type_id)
    @damage_right_to_left_min *= 1.5 if @pokemon_right.types.ids.include?(@move_right.type_id)
    @damage_right_to_left = (@damage_right_to_left * type_correction(@move_right.type_id, @pokemon_left.types[0].id)).floor if @pokemon_left.types[0].present?
    @damage_right_to_left = (@damage_right_to_left * type_correction(@move_right.type_id, @pokemon_left.types[1].id)).floor if @pokemon_left.types[1].present?
    @damage_right_to_left_min = (@damage_right_to_left_min * type_correction(@move_right.type_id, @pokemon_left.types[0].id)).floor if @pokemon_left.types[0].present?
    @damage_right_to_left_min = (@damage_right_to_left_min * type_correction(@move_right.type_id, @pokemon_left.types[1].id)).floor if @pokemon_left.types[1].present?
    @hp_remain_left = @hp_left - @damage_right_to_left
    @hp_remain_left_max = @hp_left - @damage_right_to_left_min
    render partial: "result"
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
