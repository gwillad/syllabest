Syllabest.Views.Components ||={}

class Syllabest.Views.Components.New extends Backbone.View
  template: JST["backbone/templates/components/new"]

  render: ->
    $(@el).html(@template())
    this