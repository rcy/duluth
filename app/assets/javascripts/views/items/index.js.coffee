class Duluth.Views.ItemsIndex extends Backbone.View
  el: '#items'

  template: JST['items/index']

  initialize: =>
    console.log 'items view initialize'
    @collection.bind "reset", this.render, this

  render: ->
    console.log 'items render', @collection.toJSON()
    $(@el).html @template
    @collection.each @appendItem

  appendItem: (item) ->
    view = new Duluth.Views.Item(model: item)
    $('#items').append view.render().el
