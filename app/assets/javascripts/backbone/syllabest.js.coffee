#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Syllabest =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
    new Syllabest.Routers.UsersRouter()
    Backbone.history.start(pushState: true)

$(document).ready -> Syllabest.init()