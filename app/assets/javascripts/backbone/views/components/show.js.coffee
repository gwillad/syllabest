class Syllabest.Views.Components.Show extends Backbone.View

  template: JST["backbone/templates/components/show"]

  initialize: (options)->
    console.log(@model.toJSON())
    @plain = @model.get("plaintext")

  render: ->
    $(@el).html(@template(plaintext: @plain))
    this