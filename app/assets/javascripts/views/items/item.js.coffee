class Duluth.Views.Item extends Backbone.View
  tagName: 'li'
  
  template: JST['items/item']

  render: ->
    dict = @model.toJSON()
    console.log 'item render', dict
    $(@el).html @template(dict)
    this
