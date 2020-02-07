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
        var HTML = `<a href="/calc/${pokemon.id}/set_${side}" class="pokemon__result_${side}" data-id="${pokemon.id}", data-remote="true" rel="nofollow" data-method="get">${pokemon.name}</a>`
        $(target).append(HTML);
      });
    })
    .fail(function(){
      alert("エラーが発生しました");
    });
  };

// 文字入力もしくはフォームをクリックで検索結果が表示される
  $('#search_left').on('keyup click', function(){
    var input = $('#search_left').val();
    search_ajax(input, "#search_list_left", "left");
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
