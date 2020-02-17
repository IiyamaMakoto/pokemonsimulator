$(function() {

  function status_acquire(side, stts) {
    var base_status = Number($('#'+stts+'_base_status_'+side).text());
    var iv = Number($('#'+stts+'_iv_'+side).val());
    var ev = Number($('#'+stts+'_ev_'+side).val());
    var level = Number($('#level_'+side).val());
    var value = Number($('#'+stts+'_value_'+side).val());
    nature_effect = nature_effect_calc(side, stts)
    return {base_status, iv, ev, level, value, nature_effect}
  };
  function nature_effect_calc(side, stts) {
    var nature = Number($('#nature_'+side).val());
    up_stts_id = Math.floor(nature / 10);
    down_stts_id = nature % 10;
    if (up_stts_id === down_stts_id) {
      return 1;
    } else {
      if (stts === "attack") {stts_id = 1}
      else if (stts === "defence") {stts_id = 2}
      else if (stts === "sp_atk") {stts_id = 3}
      else if (stts === "sp_def") {stts_id = 4}
      else if (stts === "speed") {stts_id = 5}
      else {return 1};
      if (stts_id === up_stts_id) {return 1.1}
      else if (stts_id === down_stts_id) {return 0.9}
      else {return 1};
    };
  }
  function hp_iv_calc(side) {
    var {base_status, iv, ev, level, value, nature_effect} = status_acquire(side, "hp");
    $('.table__hp_iv_'+side).text(iv);
    var value = Math.floor(((base_status*2) + iv + (ev*0.25))/100*level + 10 + level);
    $('#hp_value_'+side).val(value);
    $(event.target).blur();
  };
  function hp_ev_calc(side) {
    var {base_status, iv, ev, level, value, nature_effect} = status_acquire(side, "hp");
    $('.table__hp_ev_'+side).text(ev);
    var value = Math.floor(((base_status*2) + iv + (ev*0.25))/100*level + 10 + level);
    $('#hp_value_'+side).val(value);
    $(event.target).blur();
  };
  function hp_value_calc(side) {
    var {base_status, iv, ev, level, value, nature_effect} = status_acquire(side, "hp");
    var ev = Math.floor(((value - 10 - level)*100/level - (base_status*2) - iv)*4);
    if (ev <= -8 || 252 < ev) {
      var ev = "";
    } else if (-8 < ev && ev < 0) {
      var ev = 0;
    };
    $('#hp_ev_'+side).val(ev);
    $('.table__hp_ev_'+side).text(ev);
    $(event.target).blur();
  };
  function status_iv_calc(side, stts) {
    var {base_status, iv, ev, level, value, nature_effect} = status_acquire(side, stts);
    $('.table__'+stts+'_iv_'+side).text(iv);
    var value = Math.floor(Math.floor(((base_status*2) + iv + (ev*0.25))/100*level + 5)*nature_effect);
    $('#'+stts+'_value_'+side).val(value);
    $(event.target).blur();
  };
  function status_ev_calc(side, stts) {
    var {base_status, iv, ev, level, value, nature_effect} = status_acquire(side, stts);
    $('.table__'+stts+'_ev_'+side).text(ev);
    var value = Math.floor(Math.floor(((base_status*2) + iv + (ev*0.25))/100*level + 5)*nature_effect);
    $('#'+stts+'_value_'+side).val(value);
    $(event.target).blur();
  };
  function status_value_calc(side, stts) {
    var {base_status, iv, ev, level, value, nature_effect} = status_acquire(side, stts);
    var ev = Math.floor(((value - 5)*100/level - (base_status*2) - iv)*4);
    if (ev <= -8 || 252 < ev) {
      var ev = "";
    } else if (-8 < ev && ev < 0) {
      var ev = 0;
    };
    $('#'+stts+'_ev_'+side).val(ev);
    $('.table__'+stts+'_ev_'+side).text(ev);
    $(event.target).blur();
  };


  $('.left').on('change', '#hp_iv_left', function() {
    hp_iv_calc("left");
  });
  $('.left').on('change', '#hp_ev_left', function() {
    hp_ev_calc("left");
  });
  $('.left').on('change', '#hp_value_left', function() {
    hp_value_calc("left");
  });
  $('.left').on('change', '#attack_iv_left', function() {
    status_iv_calc("left", "attack");
  });
  $('.left').on('change', '#attack_ev_left', function() {
    status_ev_calc("left", "attack");
  });
  $('.left').on('change', '#attack_value_left', function() {
    status_value_calc("left", "attack");
  });
  $('.left').on('change', '#defence_iv_left', function() {
    status_iv_calc("left", "defence");
  });
  $('.left').on('change', '#defence_ev_left', function() {
    status_ev_calc("left", "defence");
  });
  $('.left').on('change', '#defence_value_left', function() {
    status_value_calc("left", "defence");
  });
  $('.left').on('change', '#sp_atk_iv_left', function() {
    status_iv_calc("left", "sp_atk");
  });
  $('.left').on('change', '#sp_atk_ev_left', function() {
    status_ev_calc("left", "sp_atk");
  });
  $('.left').on('change', '#sp_atk_value_left', function() {
    status_value_calc("left", "sp_atk");
  });
  $('.left').on('change', '#sp_def_iv_left', function() {
    status_iv_calc("left", "sp_def");
  });
  $('.left').on('change', '#sp_def_ev_left', function() {
    status_ev_calc("left", "sp_def");
  });
  $('.left').on('change', '#sp_def_value_left', function() {
    status_value_calc("left", "sp_def");
  });
  $('.left').on('change', '#speed_iv_left', function() {
    status_iv_calc("left", "speed");
  });
  $('.left').on('change', '#speed_ev_left', function() {
    status_ev_calc("left", "speed");
  });
  $('.left').on('change', '#speed_value_left', function() {
    status_value_calc("left", "speed");
  });
  $('.left').on('change', '#nature_left', function() {
    status_ev_calc("left", "attack");
    status_ev_calc("left", "defence");
    status_ev_calc("left", "sp_atk");
    status_ev_calc("left", "sp_def");
    status_ev_calc("left", "speed");
  });
})
