module CalcHelper

  def power_correction
    correction = 1
    return correction
  end

  def hp_correction
    correction = 1
    return correction
  end

  def attack_correction
    correction = 1
    return correction
  end

  def sp_atk_correction
    correction = 1
    return correction
  end

  def defence_correction
    correction = 1
    return correction
  end

  def sp_def_correction
    correction = 1
    return correction
  end

  def speed_correction
    correction = 1
    return correction
  end

  def damage_correction
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
end
