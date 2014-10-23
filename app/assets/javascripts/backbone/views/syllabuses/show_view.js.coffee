class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  events:
    'click #back_button': 'returnToUser'
    'click #new_component_button': 'addComponent'
    'hover #back_button, #new_component_button': 'highlight'

  returnToUser: ->
    Backbone.history.navigate("users/#{@model.get('user_id')}", true)

  highlight: (e) ->
  	$(e.currentTarget).toggleClass("accent")

  addComponent: (event) ->
    event.preventDefault()
    view = new Syllabest.Views.Components.New
    $('#add_component').remove()
    $('#header').append(view.render().el)

  render: ->
    $(@el).html(@template(syllabus: @model))
    this

  