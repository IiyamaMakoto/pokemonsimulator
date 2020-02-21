$(function() {

// インクリメンタルサーチを実行する部分を定義
  function search_ajax(input, target, side) {
    $.ajax({
      type: "GET",
      url: "/calc/search",
      data: {keyword: input},
      dataType: "json"
    })
    .done(function(pokemons) {
      $(target).empty();
      pokemons.forEach(function(pokemon){
        var HTML = `<div class="pokemon__result_${side}">${pokemon.name}</div>`
        $(target).append(HTML);
      });
    })
    .fail(function(){
      alert("エラーが発生しました");
    });
  };
  function result_ajax(input, side) {
    $.ajax({
      type: "GET",
      url: "/calc/result",
      data: {keyword: input},
      dataType: "json"
    })
    .done(function(pokemon) {
      $('#search_'+side).val(pokemon.name);
      $('#name_'+side).text(pokemon.name);
      $('#hp_base_status_'+side).text(pokemon.hp);
      $('#attack_base_status_'+side).text(pokemon.attack);
      $('#defence_base_status_'+side).text(pokemon.defence);
      $('#sp_atk_base_status_'+side).text(pokemon.sp_atk);
      $('#sp_def_base_status_'+side).text(pokemon.sp_def);
      $('#speed_base_status_'+side).text(pokemon.speed);
      hp_ev_calc(side);
      status_ev_calc(side, "attack");
      status_ev_calc(side, "defence");
      status_ev_calc(side, "sp_atk");
      status_ev_calc(side, "sp_def");
      status_ev_calc(side, "speed");
      $('#abilities_'+side).empty();
      pokemon.abilities.forEach(function(ability) {
        var HTML = `<option value="${ability.id}">${ability.name}</option>`
        $('#abilities_'+side).append(HTML);
      });
      $('#type_'+side).empty();
      pokemon.types.forEach(function(type) {
        var HTML = `<div class="pokemon__type--${type.id}">${type.name}</div>
                    <div class="body__hidden" id="pokemon_type1_${side}">${type.id}</div>`;
        $('#type_'+side).append(HTML);
      })
    })
    .fail(function(){
      alert("エラーが発生しました");
    });
  }

// ポケモンのステータスを計算する関数を定義
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
  function nature_correction(side, nature_id) {
    var up_status_id = Math.floor(nature_id / 10);
    var down_status_id = nature_id % 10;
    $('.table_'+side+' .table__correction--up').removeClass("table__correction--up");
    $('.table_'+side+' .table__correction--down').removeClass("table__correction--down");
    if (up_status_id === down_status_id) {return};
    $('tr[val=status_'+up_status_id+'_'+side+']').addClass("table__correction--up");
    $('tr[val=status_'+down_status_id+'_'+side+']').addClass("table__correction--down");
  };


// 文字入力もしくはフォームをクリックで検索結果が表示される
  $('#search_left').on('keyup click', function(){
    var input = $('#search_left').val();
    search_ajax(input, "#search_list_left", "left");
  })
  $('.left').on('click', '.pokemon__result_left', function() {
    var input = $(event.target).text();
    result_ajax(input, "left");
  })
  $('#search_right').on('keyup click', function(){
    var input = $('#search_right').val();
    search_ajax(input, "#search_list_right", "right");
  });
  $('.right').on('click', '.pokemon__result_right', function() {
    var input = $(event.target).text();
    result_ajax(input, "right");
  });
// どこかをクリックすると検索結果が削除される
  $(document).on("click", function(){
    $('.pokemon__search_result').empty();
  });

// ステータス部分を変更した際に再計算
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
  $('#nature_left').on('click', function() {
    $('.select_box_left').show();
      $('.select_box__line').on('mouseenter', function() {
        var nature_id = $(event.target).attr("val");
        $('#nature_left').val(nature_id);
        nature_correction("left", nature_id);
        status_ev_calc("left", "attack");
        status_ev_calc("left", "defence");
        status_ev_calc("left", "sp_atk");
        status_ev_calc("left", "sp_def");
        status_ev_calc("left", "speed");
      });
    });
  $('.select_box_left .select_box__line').on('click', function() {
    var nature_id = $(event.target).attr("val");
    $('#nature_left').val(nature_id);
    $('.select_box_left .select_box__line--selected').addClass("select_box__line").removeClass("select_box__line--selected");
    $(event.target).addClass("select_box__line--selected").removeClass("select_box__line");
    $('.select_box__line').off('mouseenter');
  });
  $('.select_box_left').on('click', function() {
    $('.select_box_left').fadeOut();
  });

  $('.right').on('change', '#hp_iv_right', function() {
    hp_iv_calc("right");
  });
  $('.right').on('change', '#hp_ev_right', function() {
    hp_ev_calc("right");
  });
  $('.right').on('change', '#hp_value_right', function() {
    hp_value_calc("right");
  });
  $('.right').on('change', '#attack_iv_right', function() {
    status_iv_calc("right", "attack");
  });
  $('.right').on('change', '#attack_ev_right', function() {
    status_ev_calc("right", "attack");
  });
  $('.right').on('change', '#attack_value_right', function() {
    status_value_calc("right", "attack");
  });
  $('.right').on('change', '#defence_iv_right', function() {
    status_iv_calc("right", "defence");
  });
  $('.right').on('change', '#defence_ev_right', function() {
    status_ev_calc("right", "defence");
  });
  $('.right').on('change', '#defence_value_right', function() {
    status_value_calc("right", "defence");
  });
  $('.right').on('change', '#sp_atk_iv_right', function() {
    status_iv_calc("right", "sp_atk");
  });
  $('.right').on('change', '#sp_atk_ev_right', function() {
    status_ev_calc("right", "sp_atk");
  });
  $('.right').on('change', '#sp_atk_value_right', function() {
    status_value_calc("right", "sp_atk");
  });
  $('.right').on('change', '#sp_def_iv_right', function() {
    status_iv_calc("right", "sp_def");
  });
  $('.right').on('change', '#sp_def_ev_right', function() {
    status_ev_calc("right", "sp_def");
  });
  $('.right').on('change', '#sp_def_value_right', function() {
    status_value_calc("right", "sp_def");
  });
  $('.right').on('change', '#speed_iv_right', function() {
    status_iv_calc("right", "speed");
  });
  $('.right').on('change', '#speed_ev_right', function() {
    status_ev_calc("right", "speed");
  });
  $('.right').on('change', '#speed_value_right', function() {
    status_value_calc("right", "speed");
  });
  $('.right').on('change', '#nature_right', function() {
    status_ev_calc("right", "attack");
    status_ev_calc("right", "defence");
    status_ev_calc("right", "sp_atk");
    status_ev_calc("right", "sp_def");
    status_ev_calc("right", "speed");
  });
  $('#nature_right').on('click', function() {
    $('.select_box_right').show();
      $('.select_box__line').on('mouseenter', function() {
        var nature_id = $(event.target).attr("val");
        $('#nature_right').val(nature_id);
        nature_correction("right", nature_id);
        status_ev_calc("right", "attack");
        status_ev_calc("right", "defence");
        status_ev_calc("right", "sp_atk");
        status_ev_calc("right", "sp_def");
        status_ev_calc("right", "speed");
      });
    });
  $('.select_box_right .select_box__line').on('click', function() {
    var nature_id = $(event.target).attr("val");
    $('#nature_right').val(nature_id);
    $('.select_box_right .select_box__line--selected').addClass("select_box__line").removeClass("select_box__line--selected");
    $(event.target).addClass("select_box__line--selected").removeClass("select_box__line");
    $('.select_box__line').off('mouseenter');
  });
  $('.select_box_right').on('click', function() {
    $('.select_box_right').fadeOut();
  });
});
