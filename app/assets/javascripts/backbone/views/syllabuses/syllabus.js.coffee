class Syllabest.Views.Syllabus extends Backbone.View
  template: JST["backbone/templates/syllabuses/syllabus"]

  tagName: 'tr'

  events: 
  	'click #view_syllabus': 'showSyllabus'

  showSyllabus: ->
  	Backbone.history.navigate("users/#{@model.get("id")}", true)

  render: ->
    $(@el).attr("syllabus-id", @model["id"])
    $(@el).html(@template(syllabus: @model))
    this