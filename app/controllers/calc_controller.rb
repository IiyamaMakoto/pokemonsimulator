class CalcController < ApplicationController
  include ApplicationHelper
  include CalcHelper
  extend ActiveHash::Associations::ActiveRecordExtensions
  before_action :set_natures, :set_items, :selectable_setting, except: :search

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
    @damage_left_to_right = 0
    @damage_left_to_right_min = 0
    @damage_right_to_left = 0
    @damage_right_to_left_min = 0
    @moves = Move.all.order(:name)
    @move = Move.first
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
    @power_left = @move_left.power * power_correction("left")
    @power_right = @move_right.power * power_correction("right")
    @hp_left = @hp_value_left * hp_correction("left")
    @hp_right = @hp_value_right * hp_correction("right")
    if @move_left.category == "物理"
      @attack_left = ((@attack_value_left * rank_correction("attack", "left")).floor * attack_correction("left")).floor
      @defence_right = ((@defence_value_right * rank_correction("defence", "right")).floor * defence_correction("right")).floor
    elsif @move_left.category == "特殊"
      @attack_left = ((@sp_atk_value_left * rank_correction("sp_atk", "left")).floor * sp_atk_correction("left")).floor
      @defence_right = ((@sp_def_value_right * rank_correction("sp_def", "right")).floor * sp_def_correction("right")).floor
    end
    @damage_left_to_right = (((@level_left * 2 / 5 + 2).floor * @power_left * @attack_left / @defence_right).floor / 50 + 2).floor
    @damage_left_to_right = (@damage_left_to_right * weather_correction(@move_left.type_id, @weather)).floor
    @damage_left_to_right_min = (@damage_left_to_right * 0.85).floor
    @damage_left_to_right *= 1.5 if @pokemon_left.types.ids.include?(@move_left.type_id)
    @damage_left_to_right_min *= 1.5 if @pokemon_left.types.ids.include?(@move_left.type_id)
    @damage_left_to_right = (@damage_left_to_right * type_correction(@move_left.type_id, @pokemon_right.types[0].id)).floor if @pokemon_right.types[0].present?
    @damage_left_to_right = (@damage_left_to_right * type_correction(@move_left.type_id, @pokemon_right.types[1].id)).floor if @pokemon_right.types[1].present?
    @damage_left_to_right_min = (@damage_left_to_right_min * type_correction(@move_left.type_id, @pokemon_right.types[0].id)).floor if @pokemon_right.types[0].present?
    @damage_left_to_right_min = (@damage_left_to_right_min * type_correction(@move_left.type_id, @pokemon_right.types[1].id)).floor if @pokemon_right.types[1].present?
    @damage_left_to_right = (@damage_left_to_right / 2).floor if @status_ailment_left == 2 && @move_left.category == "物理"
    @damage_left_to_right_min = (@damage_left_to_right_min / 2).floor if @status_ailment_left == 2 && @move_left.category == "物理"
    @damage_left_to_right = (@damage_left_to_right * damage_correction("left")).floor
    @damage_left_to_right_min = (@damage_left_to_right_min * damage_correction("left")).floor
    @hp_remain_right = @hp_right - @damage_left_to_right
    @hp_remain_right = 0 if @hp_remain_right.negative?
    @hp_remain_right_max = @hp_right - @damage_left_to_right_min
    @hp_remain_right_max = 0 if @hp_remain_right_max.negative?
    if @move_right.category == "物理"
      @attack_right = ((@attack_value_right * rank_correction("attack", "right")).floor * attack_correction("right")).floor
      @defence_left = ((@defence_value_left * rank_correction("defence", "left")).floor * defence_correction("left")).floor
    elsif @move_right.category == "特殊"
      @attack_right = ((@sp_atk_value_right * rank_correction("sp_atk", "right")).floor * sp_atk_correction("right")).floor
      @defence_left = ((@sp_def_value_left * rank_correction("sp_def", "left")).floor * sp_def_correction("left")).floor
    end
    @damage_right_to_left = (((@level_right * 2 / 5 + 2).floor * @power_right * @attack_right / @defence_left).floor / 50 + 2).floor
    @damage_right_to_left = (@damage_right_to_left * weather_correction(@move_right.type_id, @weather)).floor
    @damage_right_to_left_min = (@damage_right_to_left * 0.85).floor
    @damage_right_to_left *= 1.5 if @pokemon_right.types.ids.include?(@move_right.type_id)
    @damage_right_to_left_min *= 1.5 if @pokemon_right.types.ids.include?(@move_right.type_id)
    @damage_right_to_left = (@damage_right_to_left * type_correction(@move_right.type_id, @pokemon_left.types[0].id)).floor if @pokemon_left.types[0].present?
    @damage_right_to_left = (@damage_right_to_left * type_correction(@move_right.type_id, @pokemon_left.types[1].id)).floor if @pokemon_left.types[1].present?
    @damage_right_to_left_min = (@damage_right_to_left_min * type_correction(@move_right.type_id, @pokemon_left.types[0].id)).floor if @pokemon_left.types[0].present?
    @damage_right_to_left_min = (@damage_right_to_left_min * type_correction(@move_right.type_id, @pokemon_left.types[1].id)).floor if @pokemon_left.types[1].present?
    @damage_right_to_left = (@damage_right_to_left / 2).floor if @status_ailment_right == 2 && @move_right.category == "物理"
    @damage_right_to_left_min = (@damage_right_to_left_min / 2).floor if @status_ailment_right == 2 && @move_right.category == "物理"
    @damage_right_to_left = (@damage_right_to_left * damage_correction("right")).floor
    @damage_right_to_left_min = (@damage_right_to_left_min * damage_correction("right")).floor
    @hp_remain_left = @hp_left - @damage_right_to_left
    @hp_remain_left = 0 if @hp_remain_left.negative?
    @hp_remain_left_max = @hp_left - @damage_right_to_left_min
    @hp_remain_left_max = 0 if @hp_remain_left_max.negative?
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

end
