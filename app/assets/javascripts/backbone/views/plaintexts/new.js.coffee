Syllabest.Views.Plaintexts ||={}

class Syllabest.Views.Plaintexts.New extends Backbone.View
  template: JST["backbone/templates/plaintexts/new"]

  className: "component new"

  events:
    #'click #submit_plaintext': 'createPlainText'
    #'click #cancel_plaintext': 'cancelPlainText'
    'blur .component-title': 'createPlainText'
    'blur .component-body': 'createPlainText'

  createPlainText: (e) ->
    e.preventDefault()
    new_title = $(e.currentTarget).closest(".component").find(".component-title").text()
    new_contents = $(e.currentTarget).closest(".component").find(".component-body").html()
    new_contents = new_contents.replace(/\<div\>/g, '\n')
    new_contents = new_contents.replace(/\<\/div\>/g, '')
    new_contents = new_contents.replace(/\<br\>/g, '\n')	
    new_contents = new_contents.replace(/<br\s*\/\>/g, '\n')	
    if new_title isnt "" and new_contents isnt ""
      attributes =
        component_type: "plaintext"
        syllabus_id: @model.get('id')
        order: @collection.length + 1
        plaintext_attributes: 
          title: new_title
          contents: new_contents
         #title: $('#new_plaintext_title').val()
         #contents:  $('#new_plaintext_contents').val()
      # @plain_comp = new Syllabest.Model.Components(attributes)	
      @collection.create attributes, {wait: true}
      @collection.fetch()
      this.remove()
      this.unbind()   
    
  cancelPlainText: (e) ->
    e.preventDefault()
    this.remove()
    this.unbind()


  succeed: (response) ->
    console.log response.toJSON()

  render: ->
    $(@el).html(@template())
    this