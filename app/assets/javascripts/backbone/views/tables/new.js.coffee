Syllabest.Views.Tables ||={}

class Syllabest.Views.Tables.New extends Backbone.View
  template: JST["backbone/templates/tables/new"]

  className: "component new"

  events:
    'click #submit_table': 'createTable'
    'click #cancel_table': 'cancelTable'

  createTable: (e) ->
    e.preventDefault()
    numRows = parseInt($('#new_table_rows').val())
    numCols = parseInt($('#new_table_columns').val())
    cellContents = []
    for i in [0 .. numRows]
      colContents = []
      for j in [0 .. numCols-1]
        if i is 0
          colContents.push "Column Title"
        else
          colContents.push "Cell Data"
      cellContents.push colContents
    attributes =
      component_type: "table"
      syllabus_id: @model.get('id')
      order: @collection.length + 1
      table_attributes: 
       title: $('#new_table_title').val()
       rows:  numRows
       columns:  numCols
       contents:  cellContents
       border_class: "border_hidden"
    @collection.create attributes, {wait: true}
    @collection.fetch()
    this.remove()
    this.unbind()   
    
  cancelTable: (e) ->
    e.preventDefault()
    this.remove()
    this.unbind()


  succeed: (response) ->
    console.log response.toJSON()

  render: ->
    $(@el).html(@template())
    this