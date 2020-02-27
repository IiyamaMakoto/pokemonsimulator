module CalcHelper

  def power_correction(side)
    correction = 1
    if side == "left"
      move, item = @move_left, @item_left
    elsif side == "right"
      move, item = @move_right, @item_right
    else return
    end
    correction *= 1.5 if move.category == "物理" && item == "こだわりハチマキ"
    correction *= 1.5 if move.category == "特殊" && item == "こだわりメガネ"
    correction *= 1.1 if move.category == "物理" && item == "ちからのハチマキ"
    correction *= 1.1 if move.category == "特殊" && item == "ものしりメガネ"
    correction *= 1.3 if item == "いのちのたま"
    correction *= 1.2 if item == "タイプ強化(1.2倍)"
    correction *= 1.3 if move.type_id == 1 && item == "ノーマルジュエル"
    return correction
  end

  def hp_correction(side)
    correction = 1
    return correction
  end

  def rank_correction(stts, side)
    correction = 1
    if side == "left"
      rank =
        case stts
        when "attack" then @attack_rank_left
        when "defence" then @defence_rank_left
        when "sp_atk" then @sp_atk_rank_left
        when "sp_def" then @sp_def_rank_left
        when "speed" then @speed_rank_left
        else 0
        end
    elsif side == "right"
      rank =
        case stts
        when "attack" then @attack_rank_right
        when "defence" then @defence_rank_right
        when "sp_atk" then @sp_atk_rank_right
        when "sp_def" then @sp_def_rank_right
        when "speed" then @speed_rank_right
        else 0
        end
    else
      rank = 0
    end
    correction *= (2+rank)/2.to_f if rank > 0
    correction *= 2/(2-rank).to_f if rank < 0
    return correction
  end

  def attack_correction(side)
    correction = 1
    return correction
  end

  def sp_atk_correction(side)
    correction = 1
    return correction
  end

  def defence_correction(side)
    correction = 1
    return correction
  end

  def sp_def_correction(side)
    correction = 1
    pokemon = @pokemon_right if side == "left"
    pokemon = @pokemon_left if side == "right"
    correction *= 1.5 if pokemon.type_id == 13 && @weather == 3
    return correction
  end

  def speed_correction(side)
    correction = 1
    return correction
  end

  def damage_correction(side)
    correction = 1
    return correction
  end

  def type_correction(move_type_id, pokemon_type_id)
    correction = 1
    case move_type_id
    when 1
      correction *= 0.5 if [13, 17].include?(pokemon_type_id)
      correction = 0 if [14].include?(pokemon_type_id)
    when 2
      correction *= 2 if [5, 6, 12, 17].include?(pokemon_type_id)
      correction *= 0.5 if [2, 3, 13, 15].include?(pokemon_type_id)
    when 3
      correction *= 2 if [2, 9, 13].include?(pokemon_type_id)
      correction *= 0.5 if [3, 5, 15].include?(pokemon_type_id)
    when 4
      correction *= 2 if [3, 10].include?(pokemon_type_id)
      correction *= 0.5 if [4, 5, 15].include?(pokemon_type_id)
      correction = 0 if [9].include?(pokemon_type_id)
    when 5
      correction *= 2 if [3, 9, 13].include?(pokemon_type_id)
      correction *= 0.5 if [2, 5, 8, 10, 12, 15, 17].include?(pokemon_type_id)
    when 6
      correction *= 2 if [5, 9, 10, 15].include?(pokemon_type_id)
      correction *= 0.5 if [2, 3, 6, 17].include?(pokemon_type_id)
    when 7
      correction *= 2 if [1, 6, 13, 16, 17].include?(pokemon_type_id)
      correction *= 0.5 if [8, 10, 11, 12, 18].include?(pokemon_type_id)
      correction = 0 if [14].include?(pokemon_type_id)
    when 8
      correction *= 2 if [5, 18].include?(pokemon_type_id)
      correction *= 0.5 if [8, 9, 13, 14].include?(pokemon_type_id)
      correction = 0 if [17].include?(pokemon_type_id)
    when 9
      correction *= 2 if [2, 4, 8, 13, 17].include?(pokemon_type_id)
      correction *= 0.5 if [5, 12].include?(pokemon_type_id)
      correction = 0 if [10].include?(pokemon_type_id)
    when 10
      correction *= 2 if [5, 7, 12].include?(pokemon_type_id)
      correction *= 0.5 if [4, 13, 17].include?(pokemon_type_id)
    when 11
      correction *= 2 if [7, 8].include?(pokemon_type_id)
      correction *= 0.5 if [11, 17].include?(pokemon_type_id)
      correction = 0 if [16].include?(pokemon_type_id)
    when 12
      correction *= 2 if [5, 11, 16].include?(pokemon_type_id)
      correction *= 0.5 if [2, 7, 8, 10, 14, 17, 18].include?(pokemon_type_id)
    when 13
      correction *= 2 if [2, 6, 10, 12].include?(pokemon_type_id)
      correction *= 0.5 if [7, 9, 17].include?(pokemon_type_id)
    when 14
      correction *= 2 if [11, 14].include?(pokemon_type_id)
      correction *= 0.5 if [16].include?(pokemon_type_id)
      correction = 0 if [1].include?(pokemon_type_id)
    when 15
      correction *= 2 if [15].include?(pokemon_type_id)
      correction *= 0.5 if [17].include?(pokemon_type_id)
      correction = 0 if [18].include?(pokemon_type_id)
    when 16
      correction *= 2 if [11, 14].include?(pokemon_type_id)
      correction *= 0.5 if [16, 18].include?(pokemon_type_id)
    when 17
      correction *= 2 if [6, 13, 18].include?(pokemon_type_id)
      correction *= 0.5 if [2, 3, 4, 17].include?(pokemon_type_id)
    when 18
      correction *= 2 if [7, 15, 16].include?(pokemon_type_id)
      correction *= 0.5 if [2, 8, 17].include?(pokemon_type_id)
    end
    return correction
  end

  def weather_correction(move_type_id, weather)
    correction = 1
    correction *= 2 if move_type_id == 2 && weather == 1
    correction *= 0.5 if move_type_id == 2 && weather == 2
    correction *= 2 if move_type_id == 3 && weather == 2
    correction *= 0.5 if move_type_id == 3 && weather == 1
    return correction
  end

end
