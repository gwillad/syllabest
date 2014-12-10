Syllabest.Views.Calendars ||={}

class Syllabest.Views.Calendars.New extends Backbone.View
  template: JST["backbone/templates/calendars/new"]

  className: "component new"

  events:
    'click #submit_calendar': 'createCalendar'
    'click #cancel_calendar': 'cancelCalendar'

  createCalendar: (e) ->
    e.preventDefault()
    meeting_days = [false, false, false, false, false, false, false]
    for i in $("input:checked")
      meeting_days[$(i).attr("day_num")] = true      
    numCols = parseInt($('#new_calendar_columns').val())
    cellContents = []
    attributes =
      component_type: "calendar"
      syllabus_id: @model.get('id')
      order: @collection.length + 1
      meeting_days: meeting_days
      start_date: $("#start_date").val()
      end_date: $("#end_date").val()
      table_attributes: 
       title: $('#new_table_title').val()
       columns:  numCols
       contents:  cellContents
       border_class: "border_hidden"
    @collection.create attributes, {wait: true}
    @collection.fetch()
    this.remove()
    this.unbind()   
    
  cancelCalendar: (e) ->
    e.preventDefault()
    this.remove()
    this.unbind()


  succeed: (response) ->
    console.log response.toJSON()

  render: ->
    $(@el).html(@template())
    this