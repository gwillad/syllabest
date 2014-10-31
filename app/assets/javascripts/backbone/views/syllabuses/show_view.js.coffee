class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  events:
    'click #back_button': 'returnToUser'
    'click #new_component_button': 'addComponent'
    'hover #back_button, #new_component_button': 'highlight'
    'hover #new_plaintext_button, #new_plaintext_title, #new_table_button, #new_table_title, #new_calendar_button, #new_calendar_title, #cancel_component_button': 'highlight2'
    'click #cancel_component_button': 'cancelComponent'
    
  initialize: ->
    @usid = @model.get("user_id")
    @collection.on('reset', @render, this)
    @collection.on('add', @appendComponent, this)

  render: ->
    $(@el).html(@template(syllabus: @model))
    @collection.each(@appendComponent)
    this

  appendComponent: (c) ->
    view = new Syllabest.Views.Components.Show(model: c)
    $('#syllabus').append(view.render().el)
  
  returnToUser: ->
    Backbone.history.navigate("users/#{@model.get('user_id')}", true)

  highlight: (e) ->
    $(e.currentTarget).toggleClass("accent")

  highlight2: (e) ->
    $(e.currentTarget).parent().toggleClass("highlight")

  applyDragDrop: ->
    $('#new_plaintext_button, #new_table_button, #new_calendar_button').draggable({
      helper: "clone",
      opacity: .5,
      scope: "components",
      containment: $('.container-fluid'),
      cursor: "-webkit-grabbing"
    })
    $('#syllabus').droppable({
      scope: "components",
      over: (event, ui) ->
        console.log(ui.helper)
        $('#new_plaintext_button').draggable("option", "helper", $(JST["backbone/templates/components/box"]()))
        console.log($('#new_plaintext_button').draggable("option", "helper"))
      out: ->
        $('#new_plaintext_button').draggable("option", "helper", "clone")
    })

  addComponent: (e) ->
    #e.preventDefault()
    hash = 
      sid: @model.get('id')
      uid: @model.get('user_id')
    #@components = new Syllabest.Collections.ComponentsCollection([],hash)
    
    view = new Syllabest.Views.Components.New(model: @model, collection: @collection)
    $('#new_component_button').hide()
    syllabus_row = $('#syllabus_row').detach()
    $('#left_side').append(syllabus_row)
    $('#right_side').append(view.render().el)
    this.applyDragDrop()

  cancelComponent: (e) ->
    $('#new_component').remove()
    $('#new_component_button').show()
    syllabus_row = $('#syllabus_row').detach()
    $('.container-fluid').append(syllabus_row)
  