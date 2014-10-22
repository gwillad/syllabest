class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  render: ->
    $(@el).html(@template(syllabus: @model))
    this

  