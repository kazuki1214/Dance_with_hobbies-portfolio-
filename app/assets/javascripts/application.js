// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .



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



//投稿作成時のタグの表示UI
$(".chips").chips({
    placeholder: "タグを入力（Enterで入力で確定）",
    secondaryPlaceholder: ",で区切るとタグを追加",
    data: getChipsData($("#post-tag-field").val()),
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
    $("#").val(tags);
  });