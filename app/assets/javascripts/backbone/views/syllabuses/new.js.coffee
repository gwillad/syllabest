Syllabest.Views.Syllabuses ||={}

class Syllabest.Views.Syllabuses.New extends Backbone.View
  template: JST["backbone/templates/syllabuses/new"]

  id: "new_syllabus_view"

  render: ->
    $(@el).html(@template())
    this
