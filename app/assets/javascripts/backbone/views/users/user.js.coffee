class Syllabest.Views.User extends Backbone.View
  template: JST["backbone/templates/users/user"]

  tagName: 'tr'

  events: 
  	'click #view_user': 'showUser'

  showUser: ->
  	Backbone.history.navigate("users/#{@model.get("id")}", true)

  render: ->
    $(@el).attr("user-id", @model["id"])
    $(@el).html(@template(user: @model))
    this