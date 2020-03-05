module ApplicationHelper

  def current_status_setting
    @pokemon_left         = Pokemon.find_by(name: params[:pokemon_left].strip)
    @move_left            = Move.find_by(name: params[:move_left])
    @ability_left         = params[:ability_left]
    @item_left            = params[:item_left]
    @status_ailment_left  = params[:status_ailment_left].to_i
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
    @ability_right        = params[:ability_right]
    @item_right           = params[:item_right]
    @status_ailment_right = params[:status_ailment_right].to_i
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

    @weather              = params[:weather].to_i
    @field                = params[:field].to_i
    @trick_room           = params[:trick_room].to_i
    @wall_physical_left   = params[:wall_physical_left].to_i
    @wall_physical_right  = params[:wall_physical_right].to_i
    @wall_special_left    = params[:wall_special_left].to_i
    @wall_special_right   = params[:wall_special_right].to_i
    @tar_shot_left        = params[:tar_shot_left].to_i
    @tar_shot_right       = params[:tar_shot_right].to_i
  end

end
