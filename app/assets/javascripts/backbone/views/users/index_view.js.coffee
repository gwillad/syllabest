class Syllabest.Views.Users.IndexView extends Backbone.View
  template: JST["backbone/templates/users/index"]

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(users: @collection))
    this

 
