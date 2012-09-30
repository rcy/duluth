class Duluth.Views.Item extends Backbone.View
  tagName: 'li'
  
  template: JST['items/item']

  render: ->
    dict = @model.toJSON()
    console.log 'item render', dict
    $(@el).html @template(dict)
    # setup selection
    for kind in ['inbox', 'project', 'action', 'maybe', 'note', 'calendar']
      $option = $('<option>').text(kind).attr('value', kind)
      $option.attr('selected', true) if kind == dict.kind
      $(@el).find('select .kinds').append $option
    this
