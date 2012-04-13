// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

$("tr.item div.summary").live("click", function (e) {
  e.preventDefault();
  $(this).parent().find('.detail').toggle();
});


$("div.move_to a").live("click", function (e) {
  e.preventDefault();
  var move_to = $(this).data('move_to');
  var item = $(this).parents('li.item');
  var item_id = $(this).parents('li.item').data('id');
  $.ajax({
    type: "POST",
    url: '/items/'+item_id+'.json',
    data: { _method: "PUT", item: { kind: move_to } },
    dataType: 'json',
    success: function(msg) {
      $(item).fadeOut();
    }
  });
});

$("div.mark_as a").live("click", function (e) {
  e.preventDefault();
  var mark_as = $(this).data('mark_as');
  var item = $(this).parents('li.item');
  var item_id = $(this).parents('li.item').data('id');
  $.ajax({
    type: "POST",
    url: '/items/'+item_id+'.json',
    data: { _method: "PUT", item: { archive: true } },
    dataType: 'json',
    success: function(msg) {
      $(item).fadeOut();
    }
  });
});
