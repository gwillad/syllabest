class Syllabest.Views.User extends Backbone.View
  template: JST["backbone/templates/users/user"]

  tagName: 'li'

  render: ->
    $(@el).attr("user-id", @model["id"])
    $(@el).html(@template(user: @model))
    this