Syllabest.Views.Components ||={}

class Syllabest.Views.Components.New extends Backbone.View
  template: JST["backbone/templates/components/new"]

  id: "new_component"

  events:
    'click #new_plaintext_button, #new_table_button, #new_calendar_button': 'addComponentForm'

  addComponentForm: (e) ->
    e.preventDefault()
    component_type = $(e.currentTarget).attr("component_type")
    alert component_type
    #if component_type is "plaintext"
      #view = new Syllabest.Views.Plaintexts.New
    #else if component_type is "table"
      #view = new Syllabest.Views.Tables.New
    #else if component_type is "calendar"
      #view = new Syllabest.Views.Calendars.New

  createComponent: (e) ->
    #e.preventDefault()
    alert @collection.url
    attributes =
      component_type: $(e.currentTarget).attr("component_type")
      syllabus_id: @model.get('id')
    console.log(attributes)
    #@collection.create attributes

  render: ->
    $(@el).html(@template())
    this