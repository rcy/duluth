window.Duluth =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    items = new Duluth.Collections.Items
    itemsView = new Duluth.Views.ItemsIndex({collection: items})
    items.reset bootstrapped_items if bootstrapped_items?

$(document).ready ->
  Duluth.init()
