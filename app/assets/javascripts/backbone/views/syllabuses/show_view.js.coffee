class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  events:
    'click #back_button': 'returnToUser'
    'click #new_component_button': 'addComponent'
    'hover #back_button, #new_component_button': 'highlight'
    'click #cancel_component_button': 'cancelComponent'

  returnToUser: ->
    Backbone.history.navigate("users/#{@model.get('user_id')}", true)

  highlight: (e) ->
  	$(e.currentTarget).toggleClass("accent")

  addComponent: (e) ->
    #e.preventDefault()
    view = new Syllabest.Views.Components.New
    $('#new_component_button').hide()
    syllabus_row = $('#syllabus_row').detach()
    $('#left_side').append(syllabus_row)
    $('#right_side').append(view.render().el)

  cancelComponent: (e) =>
    $('#new_component').remove()
    $('#new_component_button').show()
    syllabus_row = $('#syllabus_row').detach()
    $('.container-fluid').append(syllabus_row)

  render: ->
    $(@el).html(@template(syllabus: @model))
    this

  