class Syllabest.Views.User extends Backbone.View
  template: JST["backbone/templates/users/user"]

  tagName: 'tr'

  events: 
  	'click #view_user': 'showUser'
  	'click #delete_user': 'destroyUser'

  showUser: ->
  	Backbone.history.navigate("users/#{@model.get("id")}", true)

  destroyUser: ->
  	$("tr[user-id=#{@model.get('id')}]").remove()
  	this.model.destroy()

  render: ->
    $(@el).attr("user-id", @model["id"])
    $(@el).html(@template(user: @model))
    this