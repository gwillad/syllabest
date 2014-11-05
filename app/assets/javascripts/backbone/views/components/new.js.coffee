Syllabest.Views.Components ||={}

class Syllabest.Views.Components.New extends Backbone.View
  template: JST["backbone/templates/components/new"]

  id: "new_component"

  events:
    'click #new_table_button, #new_calendar_button': 'addComponentForm'

  initialize: ->
    temp = this
    $('#syllabus').droppable({
      scope: "components",
      hoverClass: "accept",
      drop: (event, ui) ->
        if $(ui.draggable).attr("component_type") is "plaintext"
          temp.addPlaintext()
      over: (event, ui) ->
        #console.log(ui.helper)
        #$('#new_plaintext_button').draggable("option", "helper", $(JST["backbone/templates/components/box"]()))
        #console.log($('#new_plaintext_button').draggable("option", "helper"))
      out: ->
        $('#new_plaintext_button').draggable("option", "helper", "clone")
    })

  addPlaintext: (e) ->
    view = new Syllabest.Views.Plaintexts.New(model: @model, collection: @collection)
    $('#new_component_button').show()
    $('#new_component').remove()
    syllabus_row = $('#syllabus_row').detach()
    $('.container-fluid').append(syllabus_row)
    $('#syllabus').append(view.render().el)
    
  addComponentForm: (e) ->
    e.preventDefault()
    component_type = $(e.currentTarget).attr("component_type")
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