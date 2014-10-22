class Syllabest.Views.Syllabus extends Backbone.View
  template: JST["backbone/templates/syllabuses/syllabus"]

  tagName: 'tr'

  events: 
  	'click #view_syllabus': 'showSyllabus'

  showSyllabus: ->
  	Backbone.history.navigate("users/#{@model.get("id")}", true)

  render: ->
    $(@el).attr("user-id", @model["id"])
    $(@el).html(@template(user: @model))
    this