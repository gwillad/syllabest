Syllabest.Views.Tables ||={}

class Syllabest.Views.Tables.New extends Backbone.View
  template: JST["backbone/templates/tables/new"]

  className: "component"

  events:
    'click #submit_table': 'createTable'
    'click #cancel_table': 'cancelTable'

  createTable: (e) ->
    e.preventDefault()
    attributes =
      component_type: "table"
      syllabus_id: @model.get('id')
      order: @collection.length + 1
      table_attributes: 
       title: $('#new_table_title').val()
       rows:  parseInt($('#new_table_rows').val())
       columns:  parseInt($('#new_table_columns').val())
       
    console.log(attributes)
    # @plain_comp = new Syllabest.Model.Components(attributes)	
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