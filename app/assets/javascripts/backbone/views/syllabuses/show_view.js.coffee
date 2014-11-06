class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  events:
    'click #back_button': 'returnToUser'
    'click #new_component_button': 'addComponent'
    'hover #back_button, #new_component_button': 'highlight'
    'hover #new_plaintext_button, #new_plaintext_title, #new_table_button, #new_table_title, #new_calendar_button, #new_calendar_title, #cancel_component_button': 'highlight2'
    'click #cancel_component_button': 'cancelComponent'
    'dblclick .component-title': 'edit'
    'dblclick .component-body': 'edit'
    'blur .component-title': 'noedit'
    'blur .component-body': 'noedit'
    
  initialize: ->
    @usid = @model.get("user_id")
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(syllabus: @model))	
    @collection.comparator = "order"
    @collection.sort()
    @collection.each(@appendComponent)
    doc = this
    $('#syllabus').hover(->$('#syllabus').toggleClass("scrolling"))
    $('#components').sortable({
      axis: "y",
      containment: "#syllabus",
      cursor: "row-resize",
      scroll: true,
      zIndex: 3,
      start: (event, ui) ->
        $(ui.item).addClass("sort")
      stop: (event, ui) ->
        $(ui.item).removeClass("sort")
        compOrder = doc.getComponentsOrder()
        components = doc.collection["models"]
        for component in components
          id = component.get("id")
          index = compOrder.indexOf(id) + 1
          component.set("order", index)
          component.save()

    })
    this

  getComponentsOrder: ->
    order = []
    for each in $('.component-title')
      order.push(parseInt($(each).attr("cid")))
    order

  edit: (e) ->
    $('#components').sortable("disable")
    $(e.currentTarget).attr('contenteditable', true)
    $(e.currentTarget).attr('spellcheck', false)
    $(e.currentTarget).focus()

  noedit: (e) ->
    $(e.currentTarget).attr('contenteditable', false)
    $('#components').sortable("enable")

  applyDrag: ->
    $('#new_plaintext_button, #new_table_button, #new_calendar_button').draggable({
      helper: "clone",
      opacity: .5,
      scope: "components",
      containment: $('.container-fluid'),
      cursor: "-webkit-grabbing"
    })

  appendComponent: (c) ->
    view = new Syllabest.Views.Components.Show(model: c)
    $('#components').append(view.render().el)
  
  returnToUser: ->
    Backbone.history.navigate("users/#{@model.get('user_id')}", true)

  highlight: (e) ->
    $(e.currentTarget).toggleClass("accent")

  highlight2: (e) ->
    $(e.currentTarget).parent().toggleClass("highlight")

  addComponent: (e) ->
    e.preventDefault()
    hash = 
      sid: @model.get('id')
      uid: @model.get('user_id')
    #@components = new Syllabest.Collections.ComponentsCollection([],hash)
    
    view = new Syllabest.Views.Components.New(model: @model, collection: @collection)
    $('#new_component_button').hide()
    syllabus_row = $('#syllabus_row').detach()
    $('#left_side').append(syllabus_row)
    $('#right_side').append(view.render().el)
    this.applyDrag()

  cancelComponent: (e) ->
    $('#new_component').remove()
    $('#new_component_button').show()
    syllabus_row = $('#syllabus_row').detach()
    $('.container-fluid').append(syllabus_row)
  