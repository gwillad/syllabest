class Syllabest.Views.Components.Show extends Backbone.View

  className: "component"

  initialize: (options)->
    @type = @model.get("component_type")
    if @type is "plaintext"
      @component = @model.get("plaintext_attributes")
      @template = JST["backbone/templates/plaintexts/show"]
    if @type is "table"
      @component = @model.get("table_attributes")
      @template = JST["backbone/templates/tables/show"]

  render: ->
    $(@el).html(@template(component: @component, type: @type))
    this