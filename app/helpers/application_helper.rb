module ApplicationHelper

  def current_status_setting
    @pokemon_left         = Pokemon.find_by(name: params[:pokemon_left].strip)
    @move_left            = Move.find_by(name: params[:move_left])
    @hp_value_left        = params[:hp_value_left].to_i
    @attack_value_left    = params[:attack_value_left].to_i
    @defence_value_left   = params[:defence_value_left].to_i
    @sp_atk_value_left    = params[:sp_atk_value_left].to_i
    @sp_def_value_left    = params[:sp_def_value_left].to_i
    @speed_value_left     = params[:speed_value_left].to_i
    @attack_rank_left     = params[:attack_rank_left].to_i
    @defence_rank_left    = params[:defence_rank_left].to_i
    @sp_atk_rank_left     = params[:sp_atk_rank_left].to_i
    @sp_def_rank_left     = params[:sp_def_rank_left].to_i
    @speed_rank_left      = params[:speed_rank_left].to_i
    @accuracy_rank_left   = params[:accuracy_rank_left].to_i
    @evasion_rank_left    = params[:evasion_rank_left].to_i
    @critical_rank_left   = params[:critical_rank_left].to_i
    @level_left           = params[:level_left].to_i
    @pokemon_right        = Pokemon.find_by(name: params[:pokemon_right].strip)
    @move_right           = Move.find_by(name: params[:move_right])
    @hp_value_right       = params[:hp_value_right].to_i
    @attack_value_right   = params[:attack_value_right].to_i
    @defence_value_right  = params[:defence_value_right].to_i
    @sp_atk_value_right   = params[:sp_atk_value_right].to_i
    @sp_def_value_right   = params[:sp_def_value_right].to_i
    @speed_value_right    = params[:speed_value_right].to_i
    @attack_rank_right    = params[:attack_rank_right].to_i
    @defence_rank_right   = params[:defence_rank_right].to_i
    @sp_atk_rank_right    = params[:sp_atk_rank_right].to_i
    @sp_def_rank_right    = params[:sp_def_rank_right].to_i
    @speed_rank_right     = params[:speed_rank_right].to_i
    @accuracy_rank_right  = params[:accuracy_rank_right].to_i
    @evasion_rank_right   = params[:evasion_rank_right].to_i
    @critical_rank_right  = params[:critical_rank_right].to_i
    @level_right          = params[:level_right].to_i
  end

end
