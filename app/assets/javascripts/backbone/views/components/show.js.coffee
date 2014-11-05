class Syllabest.Views.Components.Show extends Backbone.View

  template: JST["backbone/templates/components/show"]

  className: "component"

  initialize: (options)->
    @plain = @model.get("plaintext")

  render: ->
    $(@el).html(@template(plaintext: @plain))
    this