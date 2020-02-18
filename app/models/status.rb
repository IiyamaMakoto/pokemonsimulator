class Status
  def initialize(pokemon)
    @model_name = "status"
    @hp_iv = 31
    @hp_ev = 0
    @attack_iv = 31
    @attack_ev = 0
    @defence_iv = 31
    @defence_ev = 0
    @sp_atk_iv = 31
    @sp_atk_ev = 0
    @sp_def_iv = 31
    @sp_def_ev = 0
    @speed_iv = 31
    @speed_ev = 0
    @nature_id = 11
    @level = 50
    @hp_value = (((@hp_ev*0.25)+pokemon.hp*2+@hp_iv)/100*@level+10+@level).floor
    @hp_value = 1 if pokemon.hp == 1
    @attack_value = (((@attack_ev*0.25)+pokemon.attack*2+@attack_iv)/100*@level+5).floor
    @attack_value = (@attack_value*1.1).floor if @nature_id/10.floor == 1 && @nature_id%10 != 1
    @attack_value = (@attack_value*0.9).floor if @nature_id/10.floor != 1 && @nature_id%10 == 1
    @defence_value = (((@defence_ev*0.25)+pokemon.defence*2+@defence_iv)/100*@level+5).floor
    @defence_value = (@defence_value*1.1).floor if @nature_id/10.floor == 2 && @nature_id%10 != 2
    @defence_value = (@defence_value*0.9).floor if @nature_id/10.floor != 2 && @nature_id%10 == 2
    @sp_atk_value = (((@sp_atk_ev*0.25)+pokemon.sp_atk*2+@sp_atk_iv)/100*@level+5).floor
    @sp_atk_value = (@sp_atk_value*1.1).floor if @nature_id/10.floor == 3 && @nature_id%10 != 3
    @sp_atk_value = (@sp_atk_value*0.9).floor if @nature_id/10.floor != 3 && @nature_id%10 == 3
    @sp_def_value = (((@sp_def_ev*0.25)+pokemon.sp_def*2+@sp_def_iv)/100*@level+5).floor
    @sp_def_value = (@sp_def_value*1.1).floor if @nature_id/10.floor == 4 && @nature_id%10 != 4
    @sp_def_value = (@sp_def_value*0.9).floor if @nature_id/10.floor != 4 && @nature_id%10 == 4
    @speed_value = (((@speed_ev*0.25)+pokemon.speed*2+@speed_iv)/100*@level+5).floor
    @speed_value = (@speed_value*1.1).floor if @nature_id/10.floor == 5 && @nature_id%10 != 5
    @speed_value = (@speed_value*0.9).floor if @nature_id/10.floor != 5 && @nature_id%10 == 5
  end

  def model_name
    @model_name
  end

  def hp_iv
    @hp_iv
  end

  def hp_ev
    @hp_ev 
  end

  def hp_value
    @hp_value 
  end

  def attack_iv
    @attack_iv 
  end

  def attack_ev
    @attack_ev
  end

  def attack_value
    @attack_value
  end

  def defence_iv
    @defence_iv
  end

  def defence_ev
    @defence_ev
  end

  def defence_value
    @defence_value
  end

  def sp_atk_iv
    @sp_atk_iv
  end

  def sp_atk_ev
    @sp_atk_ev
  end

  def sp_atk_value
    @sp_atk_value
  end

  def sp_def_iv
    @sp_def_iv
  end

  def sp_def_ev
    @sp_def_ev
  end

  def sp_def_value
    @sp_def_value
  end

  def speed_iv
    @speed_iv
  end

  def speed_ev
    @speed_ev
  end

  def speed_value
    @speed_value
  end

  def nature_id
    @nature_id
  end

  def level
    @level
  end
end
