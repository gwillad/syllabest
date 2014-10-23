class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  events:
    'click #back_button': 'returnToUser'
    'click #new_component_button': 'addComponent'
    'mouseenter #back_button': 'highlight_back'
    'mouseleave #back_button': 'unhighlight_back'
    'mouseenter #new_component_button': 'highlight_new'
    'mouseleave #new_component_button': 'unhighlight_new'

  returnToUser: ->
    Backbone.history.navigate("users/#{@model.get('user_id')}", true)

  highlight_back: ->
  	$('#back_button').addClass("accent")

  unhighlight_back: ->
    $('#back_button').removeClass("accent")

  highlight_new: ->
    $('#new_component_button').addClass("accent")

  unhighlight_new: ->
    $('#new_component_button').removeClass("accent")

  addComponent: (event) ->
    event.preventDefault()
    view = new Syllabest.Views.Components.New
    $('#add_component').remove()
    $('#header').after(view.render().el)

  render: ->
    $(@el).html(@template(syllabus: @model))
    this

  