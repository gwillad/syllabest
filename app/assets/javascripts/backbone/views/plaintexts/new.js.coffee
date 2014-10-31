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
      plaintext_attributes: 
       title: $('#new_plaintext_title').val()
       contents:  $('#new_plaintext_contents').val()	
    @collection.create attributes, success: (response) ->
      console.log response.toJSON()
    this.remove()
    this.unbind()    
    
  cancelPlainText: (e) ->
    e.preventDefault()
    this.remove()
    this.unbind()



  render: ->
    $(@el).html(@template())
    this