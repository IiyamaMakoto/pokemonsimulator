$(function() {

// インクリメンタルサーチを実行する部分
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
      hp_ev_calc("left");
      status_ev_calc("left", "attack");
      status_ev_calc("left", "defence");
      status_ev_calc("left", "sp_atk");
      status_ev_calc("left", "sp_def");
      status_ev_calc("left", "speed");
    })
    .fail(function(){
      alert("エラーが発生しました");
    });
  }

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
  })
// どこかをクリックすると検索結果が削除される
  $(document).on("click", function(){
    $('.pokemon__search_result').empty();
  })
});
