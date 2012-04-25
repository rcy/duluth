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
//= require jquery.jeditable.mini
//= require_tree .

function flash(text) {
  console && console.log && console.log(text);
}

function error(x) {
  alert(x);
}

function focus() {
  $("input.focus").focus();
}  

function save_summary(item_id, new_val, old_val) {
  $.ajax({
    type: "POST",
    url: '/items/'+item_id,
    data: { _method: "PUT", item: {summary: new_val} },
    success: function(new_item_html) {
      flash('successfully updated: ' + item_id);
    },
    error: function(x) {
      error('ERROR:' + x.status + ' ' + x.statusText);
    }
  });
}

function init_editables() {
  $(".summary.edit").editable(function(value, settings) {
    var id = $(this).parent().data('id');
    save_summary(id, value);
    return(value);
  }, { 
    event: 'dblclick',
    submit: 'OK',
    cancel: 'Cancel',
    //tooltip: 'Double click to edit',
    style: 'inherit'
  });
};

$(function() {
  init_editables();
  focus();

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
        init_editables();
      }
    });

  });

  // $('.focus a').click(function(e) {
  //   e.preventDefault();
  //   var kind = $(this).data('focus');
  //   if (kind === 'all') {
  //     $('.item').show();
  //   } else {
  //     $('.item').hide();
  //     $('.item.'+kind).show();
  //   }
  // });

});
