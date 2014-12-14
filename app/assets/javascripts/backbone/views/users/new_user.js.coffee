class Syllabest.Views.Users.New extends Backbone.View
  template: JST["backbone/templates/users/new"]

  initialize: ->
    alert "New_user.js.coffee"

  render: ->
    console.log 55
    $(@el).html(@template())
    console.log 99
    this