class Duluth.Models.Item extends Backbone.Model
  defaults:
    summary: ""

  initialize: ->
    console.log 'item model init', @get('summary')