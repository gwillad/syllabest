class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  events:
    'click #add_component': 'addComponent'
    'click #back_button': 'returnToUser'
    'mouseenter #back_button': 'highlight'
    'mouseleave #back_button': 'unhighlight'

  returnToUser: ->
    Backbone.history.navigate("users/#{@model.get('user_id')}", true)

  highlight: ->
  	$('#back_button').addClass("accent")

  unhighlight: ->
    $('#back_button').removeClass("accent")

  addComponent: (event) ->
    event.preventDefault()
    view = new Syllabest.Views.Components.New
    $('#add_component').remove()
    $('#header').after(view.render().el)

  render: ->
    $(@el).html(@template(syllabus: @model))
    this

  