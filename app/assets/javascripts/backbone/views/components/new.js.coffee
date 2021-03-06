Syllabest.Views.Components ||={}

class Syllabest.Views.Components.New extends Backbone.View
  template: JST["backbone/templates/components/new"]

  id: "edit_tab"

  initialize: ->
    doc = this
    $('#syllabus').droppable({
      scope: "components",
      drop: (event, ui) ->
        doc.addPlaintext() if $(ui.draggable).attr("component_type") is "plaintext"
        doc.addTable() if $(ui.draggable).attr("component_type") is "table"	
        doc.addCalendar() if $(ui.draggable).attr("component_type") is "calendar"	
      over: (event, ui) ->
        ui.helper.css("color", "#6CBC51")
        ui.helper.css("opacity", "1")
      out: (event, ui) ->
        ui.helper.css("color", "white")
        ui.helper.css("opacity", ".5")
    })

  addPlaintext: (e) ->
    view = new Syllabest.Views.Plaintexts.New(model: @model, collection: @collection)
    $('#components').append(view.render().el)

  addTable: (e) ->
    view = new Syllabest.Views.Tables.New(model: @model, collection: @collection)
    $('#components').append(view.render().el)

  addCalendar: (e) ->
    view = new Syllabest.Views.Calendars.New(model: @model, collection: @collection)
    $('#components').append(view.render().el)

  render: ->
    $(@el).html(@template(syllabus: @model, user: @user))
    this
