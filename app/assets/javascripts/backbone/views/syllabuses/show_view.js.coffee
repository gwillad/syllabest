class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  events:
    'click #back_button': 'returnToUser'
    'click #new_component_button': 'addComponent'
    'click #new_component_button': 'createComponent'
    'hover #back_button, #new_component_button': 'highlight'

  returnToUser: ->
    Backbone.history.navigate("users/#{@model.get('user_id')}", true)

  highlight: (e) ->
  	$(e.currentTarget).toggleClass("accent")

  createComponent: ->
    #event.preventDefault()
    alert @collection.url
    attributes =
      component_type: "plaintext"
      child_id: 1
      syllabus_id: 1
    @collection.create attributes

  addComponent: (event) ->
    event.preventDefault()
    view = new Syllabest.Views.Components.New
    $('#add_component').remove()
    $('#header').append(view.render().el)

  render: ->
    $(@el).html(@template(syllabus: @model))
    this

  