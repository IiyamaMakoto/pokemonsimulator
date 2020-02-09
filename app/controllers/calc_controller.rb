class CalcController < ApplicationController
  extend ActiveHash::Associations::ActiveRecordExtensions
  before_action :set_natures, :set_weathers

  def index
    @pokemon_left = Pokemon.find_by_name "ミミッキュ"
    left_status_setting
    @pokemon_right = Pokemon.find_by_name "ドリュウズ"
    right_status_setting
  end

  def set_left
    @pokemon_left = Pokemon.find(params[:id])
    left_status_setting
  end

  def set_right
    @pokemon_right = Pokemon.find(params[:id])
    right_status_setting
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

  def default_status
    {level: 50,
      hp_iv: 31, hp_ev: 0,
      attack_iv: 31, attack_ev: 0,
      defence_iv: 31, defence_ev: 0,
      sp_atk_iv: 31, sp_atk_ev: 0,
      sp_def_iv: 31, sp_def_ev: 0,
      speed_iv: 31, speed_ev: 0,
      nature_id: 11
    }
  end

  def status_calc(pokemon, status)
    status[:hp_value] = (((status[:hp_ev]*0.25)+pokemon.hp*2+status[:hp_iv])/100*status[:level]+10+status[:level]).floor
    status[:hp_value] = 1 if pokemon.hp == 1
    status[:attack_value] = (((status[:attack_ev]*0.25)+pokemon.attack*2+status[:attack_iv])/100*status[:level]+5).floor
    status[:attack_value] = (status[:attack_value]*1.1).floor if status[:nature_id]/10.floor == 1 && status[:nature_id]%10 != 1
    status[:attack_value] = (status[:attack_value]*0.9).floor if status[:nature_id]/10.floor != 1 && status[:nature_id]%10 == 1
    status[:defence_value] = (((status[:defence_ev]*0.25)+pokemon.defence*2+status[:defence_iv])/100*status[:level]+5).floor
    status[:defence_value] = (status[:defence_value]*1.1).floor if status[:nature_id]/10.floor == 2 && status[:nature_id]%10 != 2
    status[:defence_value] = (status[:defence_value]*0.9).floor if status[:nature_id]/10.floor != 2 && status[:nature_id]%10 == 2
    status[:sp_atk_value] = (((status[:sp_atk_ev]*0.25)+pokemon.sp_atk*2+status[:sp_atk_iv])/100*status[:level]+5).floor
    status[:sp_atk_value] = (status[:sp_atk_value]*1.1).floor if status[:nature_id]/10.floor == 3 && status[:nature_id]%10 != 3
    status[:sp_atk_value] = (status[:sp_atk_value]*0.9).floor if status[:nature_id]/10.floor != 3 && status[:nature_id]%10 == 3
    status[:sp_def_value] = (((status[:sp_def_ev]*0.25)+pokemon.sp_def*2+status[:sp_def_iv])/100*status[:level]+5).floor
    status[:sp_def_value] = (status[:sp_def_value]*1.1).floor if status[:nature_id]/10.floor == 4 && status[:nature_id]%10 != 4
    status[:sp_def_value] = (status[:sp_def_value]*0.9).floor if status[:nature_id]/10.floor != 4 && status[:nature_id]%10 == 4
    status[:speed_value] = (((status[:speed_ev]*0.25)+pokemon.speed*2+status[:speed_iv])/100*status[:level]+5).floor
    status[:speed_value] = (status[:speed_value]*1.1).floor if status[:nature_id]/10.floor == 5 && status[:nature_id]%10 != 5
    status[:speed_value] = (status[:speed_value]*0.9).floor if status[:nature_id]/10.floor != 5 && status[:nature_id]%10 == 5
  end

  def left_status_setting
    @status_left = default_status
    status_calc(@pokemon_left, @status_left)
  end

  def right_status_setting
    @status_right = default_status
    status_calc(@pokemon_right, @status_right)
  end
end
