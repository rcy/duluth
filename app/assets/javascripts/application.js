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
//= require fancybox
//= require_tree .

$(function() {
  $("span.summary").click(function(e) {
    var id = $(this).parent().data('id')
    $.fancybox({
      href: "items/"+id,
      overlayOpacity: '.95', overlayColor: '#000',
      centerOnScroll: true,
    });
  });

  $("input.focus").focus();

  $(".item .kind select").live("change", function(e) {
    e.preventDefault();
    var kind = $(this).find('option:selected').val();
    var item = $(this).parents('.item')
    var item_id = $(item).data('id');

    var data;

    var complex = kind.split(':');
    if (complex[0] === 'do') {
      if (complex[1] === 'archive') {
        data = {archive: true};
      } else if (complex[1] === 'unarchive') {
        data = {archive: false};
      } else {
        // archive and unarchive are the only options
        alert("bad things");
      }
    } else {
      data = {kind: kind}
    }

    $.ajax({
      type: "POST",
      url: '/items/'+item_id,
      data: { _method: "PUT", item: data },
      success: function(new_item_html) {
        $(item).replaceWith(new_item_html);
      }
    });

  });

  $('.focus a').click(function(e) {
    e.preventDefault();
    var kind = $(this).data('focus');
    if (kind === 'all') {
      $('.item').show();
    } else {
      $('.item').hide();
      $('.item.'+kind).show();
    }
  });

});
