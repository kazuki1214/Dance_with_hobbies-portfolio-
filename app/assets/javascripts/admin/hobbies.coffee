# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(".chips").chips({
    data: getChipsData($("#category_hidden_field").val()),
  });

  // chipsの初期データを取得するメソッド
  function getChipsData(values) {
    return !values
      ? []
      : values.split(",").map(function (value) {
          return { tag: value };
        });
  }

  // 作成時にchipsの値をフォームに格納
  $("#idea-btn").on("click", function () {
    const tags = M.Chips.getInstance($(".chips")).chipsData.map(function (
      value
    ) {
      return value["tag"];
    });
    $("#category_hidden_field").val(tags);
  });