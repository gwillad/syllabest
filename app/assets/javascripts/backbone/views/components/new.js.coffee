Syllabest.Views.Components ||={}

class Syllabest.Views.Components.New extends Backbone.View
  template: JST["backbone/templates/components/new"]

  events:
    'click #new_plaintext_button, #new_table_button, #new_calendar_button': 'addComponentForm'
    'hover #new_plaintext_button, #new_table_button, #new_calendar_button': 'highlight'
    'click #cancel_component_button': 'cancelComponent'

  highlight: (e) ->
  	$(e.currentTarget).toggleClass("accent")

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

  cancelComponent: ->
    $('#new_component_tab').hide()
    $('#new_component_button').show()
    syllabus_row = $('#syllabus_row').detach()
    $('.container-fluid').append(syllabus_row)

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