class Syllabest.Views.Users.IndexView extends Backbone.View
  template: JST["backbone/templates/users/index"]

  render: ->
    $(@el).html(@template(users: @collection))
    this

 
