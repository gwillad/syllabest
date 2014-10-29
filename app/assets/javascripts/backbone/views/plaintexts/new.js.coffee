Syllabest.Views.Plaintexts ||={}

class Syllabest.Views.Plaintexts.New extends Backbone.View
  template: JST["backbone/templates/plaintexts/new"]

  events:
    'click #submit_plaintext': 'createPlainText'
    'click #cancel_plaintext': 'cancelPlainText'

  createPlainText: (e) ->
    e.preventDefault()
    attributes =
      component_type: "plaintext"
      syllabus_id: @model.get('id')
    @collection.create attributes,
    success: (r)-> 
      console.log r
    
    
    
  cancelPlainText: (e) ->
    e.preventDefault()
    this.remove()
    this.unbind()



  render: ->
    $(@el).html(@template())
    this