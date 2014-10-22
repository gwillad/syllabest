class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  events:
  	'click #back_button': 'returnToUser'
  	'mouseenter #back_button': 'highlight'
  	'mouseleave #back_button': 'unhighlight'

  returnToUser: ->
    Backbone.history.navigate("users/#{@model.get('user_id')}", true)

  highlight: ->
  	$('#back_button').addClass("accent")

  unhighlight: ->
    $('#back_button').removeClass("accent")

  render: ->
    $(@el).html(@template(syllabus: @model))
    this

  