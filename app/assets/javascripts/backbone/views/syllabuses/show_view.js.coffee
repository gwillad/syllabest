class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  events:
    'click #back_button': 'returnToUser'
    'click #edit_button': 'openEditTab'
    'hover #back_button, #edit_button': 'highlight'
    'hover #new_plaintext_button, #new_plaintext_label, #new_table_button, #new_table_label, #new_calendar_button, #new_calendar_label, #cancel_edit_button': 'highlight2'
    'hover .component': 'animateComponent'
    'hover .delete_component': 'highlightDelete'
    'click .delete_component': 'deleteComponent'
    'click #cancel_edit_button': 'cancelEdit'
    'dblclick .component-title': 'edit'
    'dblclick .component-body': 'edit'
    'dblclick .component-cell': 'edit'
    'blur .component-title': 'noedit'
    'blur .component-body': 'noedit'
    'blur .component-cell': 'noedit'
    
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
      opacity: .8,
      cursor: "row-resize",
      scroll: true,
      zIndex: 3,
      start: (event, ui) ->
        $(ui.item).find(".delete_component").removeClass("show_delete")
        $(ui.item).addClass("select")
      stop: (event, ui) ->
        $(ui.item).find(".delete_component").addClass("show_delete")
        $(ui.item).removeClass("select")
        doc.updateComponentsOrder()
    })
    this

  updateComponentsOrder: ()->
    doc = this
    compOrder = []
    for each in $('.component-title')
      compOrder.push(parseInt($(each).attr("cid")))
    components = doc.collection["models"]
    for component in components
      id = component.get("id")
      index = compOrder.indexOf(id) + 1
      component.set("order", index)
      component.save()

  edit: (e) ->
    $('#components').sortable("disable")
    $(e.currentTarget).closest(".component").addClass("select")
    $(e.currentTarget).attr('contenteditable', true)
    $(e.currentTarget).attr('spellcheck', false)
    $(e.currentTarget).focus()
    $(e.currentTarget).on('keydown', (event) ->
      if event.keyCode is 9
        if $(e.currentTarget).attr("class") isnt "component-title"
          changeTo = ".component-title"
        else
          if $(e.currentTarget).attr("component_type") is "plaintext"
            changeTo = ".component-body"
          else
            changeTo = ".component-table"
        $(e.currentTarget).closest(".component").find(changeTo).trigger("dblclick")
    )

  noedit: (e) ->
    $(e.currentTarget).closest(".component").removeClass("select")
    $(e.currentTarget).attr('contenteditable', false)
    $('#components').sortable("enable")
    is_new = $(e.currentTarget).closest(".component").hasClass("new")
    if not is_new
      type = $(e.currentTarget).attr('component_type')
      if type is "plaintext"
        field = if $(e.currentTarget).attr('class') == "component-body" then "contents" else "title"
      if type is "table"
        field = if $(e.currentTarget).attr('class') == "component-cell" then "contents" else "title"
      component = @collection.get(parseInt($(e.currentTarget).attr("cid")))
      attributes = type + "_attributes"
      instance = component.get(attributes)
      if type is "table" and field is "contents"
        rowVals = []
        for i in $("tr")
          colVals = []
          for j in $(i).find(".component-cell")
            colVals.push $(j).text()
          rowVals.push colVals
        instance[field] = rowVals
      else
        if $(e.currentTarget).text() is ""
          $(e.currentTarget).text(instance[field])
        instance[field] = $(e.currentTarget).text()
      component.set(attributes, instance)
      component.save()

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

  animateComponent: (e) ->
    $(e.currentTarget).find('.delete_component').toggleClass("show_delete")
    $(e.currentTarget).toggleClass("show_component_outline")

  highlightDelete: (e) ->
    $(e.currentTarget).toggleClass("delete")

  deleteComponent: (e) ->
    is_new = $(e.currentTarget).closest(".component").hasClass("new")
    if not is_new
      component = @collection.get(parseInt($(e.currentTarget).parents().find(".component-title").attr("cid")))
    $(e.currentTarget).closest(".component").remove()
    if not is_new
      component.destroy()

  openEditTab: (e) ->
    e.preventDefault()
    hash = 
      sid: @model.get('id')
      uid: @model.get('user_id')
    #@components = new Syllabest.Collections.ComponentsCollection([],hash)
    
    view = new Syllabest.Views.Components.New(model: @model, collection: @collection)
    $('#edit_button').hide()
    syllabus_row = $('#syllabus_row').detach()
    $('#left_side').append(syllabus_row)
    $('#right_side').append(view.render().el)
    this.applyDrag()

  cancelEdit: (e) ->
    $('#edit_tab').remove()
    $('#edit_button').show()
    syllabus_row = $('#syllabus_row').detach()
    $('.container-fluid').append(syllabus_row)
  