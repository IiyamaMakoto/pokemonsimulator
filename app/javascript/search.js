$(function() {

// インクリメンタルサーチを実行する部分
  function search_ajax(input, target) {
    $.ajax({
      type: "GET",
      url: "/calc/search",
      data: {keyword: input},
      dataType: "json"
    })
    .done(function(pokemons) {
      $(target).empty();
      pokemons.forEach(function(pokemon){
        var HTML = `<div class="pokemon__result" data-id="${pokemon.id}">${pokemon.name}</div>`
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
    search_ajax(input, "#search_list_left");
  })
  $('#search_right').on('keyup click', function(){
    var input = $('#search_right').val();
    search_ajax(input, "#search_list_right");
  })
// どこかをクリックすると検索結果が削除される
  $(document).on("click", function(){
    $('.search_result').empty();
  })
});
