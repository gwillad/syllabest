class Syllabest.Views.Users.New extends Backbone.View
  template: JST["backbone/templates/users/new"]

  render: ->
    $(@el).html(@template())
    this