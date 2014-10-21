Syllabest.Views.Syllabuses ||={}

class Syllabest.Views.Syllabuses.New extends Backbone.View
  template: JST["backbone/templates/syllabuses/new"]

  render: ->
    $(@el).html(@template())
    this
