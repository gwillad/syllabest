class Syllabest.Views.Components.Show extends Backbone.View

  template: JST["backbone/templates/components/show"]

  initialize: (options)->
    a = @model.url().split("/")
    # console.log @model.url() 
    hash =
      #uid: @model.get("user_id")
      #sid: @model.get("syllabus_id")
      #cid: @model.get("id")
      uid: a[3]
      sid: a[5]
      cid: a[7]
    @collection = new Syllabest.Collections.PlaintextsCollection([],hash)
    @collection.fetch() 
    @collection.on('reset',@renderC,this)
    

  renderC: ->
    $(@el).html(@template(plaintext: @collection.first()))
    this