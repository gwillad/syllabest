class Syllabest.Views.Syllabuses.ShowView extends Backbone.View
  template: JST["backbone/templates/syllabuses/show"]

  events:
    'click #back_button': 'returnToUser'
    'click #edit_button': 'openEditTab'
    'hover #pdf_button, #back_button, #edit_button, .toggle_grid, .delete_component': 'highlight'
    'hover #new_plaintext, #new_table, #new_calendar, #cancel_edit_button': 'highlight2'
    'hover .component': 'animateComponent'
    'click .delete_component': 'deleteComponent'
    'click .toggle_grid': 'toggleGrid'
    'click #pdf_button': 'goToPDF'
    'click #cancel_edit_button': 'cancelEdit'
    'dblclick .component-title': 'edit'
    'dblclick .component-body': 'edit'
    'dblclick .component-cell': 'edit'
    'blur .component-title': 'noedit'
    'blur .component-body': 'noedit'
    'blur .component-cell': 'noedit'
    
  initialize: (options)->
    @usid = @model.get("user_id")
    @user = options["user"]
    @editMode = false
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(syllabus: @model, user: @user))
    @collection.comparator = "order"
    @collection.sort()
    @collection.each(@appendComponent)
    $('#syllabus').hover(->$('#syllabus').toggleClass("scrolling"))
    this.openEditTab() if @editMode
    this

  applyDrag: ->
    $('#new_plaintext_button, #new_table_button, #new_calendar_button').draggable({
      helper: "clone",
      opacity: .5,
      scope: "components",
      containment: $('.container-fluid'),
      cursor: "-webkit-grabbing",
      drag: (event, ui) ->
        $('#new_plaintext, #new_table, #new_calendar').removeClass("highlight")
    })

  applySort: ->
    doc = this
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
    if $('#syllabus').hasClass("editable")
      $('#components').sortable("disable")
      $(e.currentTarget).closest(".component").addClass("select")
      $(e.currentTarget).attr('contenteditable', true)
      $(e.currentTarget).attr('spellcheck', false)
      $(e.currentTarget).focus()
      $(e.currentTarget).on('keydown', (event) ->
        #console.log(event.keyCode)
        #if event.keyCode is 13
          #if $(e.currentTarget).attr("class") isnt "component-title"
            #changeTo = ".component-title"
          #else
            #if $(e.currentTarget).attr("component_type") is "plaintext"
              #changeTo = ".component-body"
            #else
              #changeTo = ".component-table"
          #$(e.currentTarget).closest(".component").find(changeTo).trigger("dblclick")
      )

  noedit: (e) ->
    if $('#syllabus').hasClass("editable")
      $(e.currentTarget).closest(".component").removeClass("select")
      $(e.currentTarget).attr('contenteditable', false)
      $('#components').sortable("enable")
      is_new = $(e.currentTarget).closest(".component").hasClass("new")
      if not is_new
        type = $(e.currentTarget).attr('component_type')
        if type is "plaintext"
          field = if $(e.currentTarget).hasClass("component-body") then "contents" else "title"
        if type is "table"
          field = if $(e.currentTarget).hasClass("component-cell") then "contents" else "title"
        component = @collection.get(parseInt($(e.currentTarget).attr("cid")))
        attributes = type + "_attributes"
        instance = component.get(attributes)
        if type is "table" and field is "contents"
          rowVals = []
          for i in $(e.currentTarget).closest("tbody").find("tr")
            colVals = []
            for j in $(i).find(".component-cell")
              colVals.push $(j).text()
            rowVals.push colVals
          instance[field] = rowVals
        else
          if $(e.currentTarget).text() is ""
            $(e.currentTarget).text(instance[field])
          instance[field] = $(e.currentTarget).html()
        component.set(attributes, instance)
        component.save()

  appendComponent: (c) ->
    view = new Syllabest.Views.Components.Show(model: c)
    $('#components').append(view.render().el)
  
  returnToUser: ->
    Backbone.history.navigate("users/#{@model.get('user_id')}", true)

  highlight: (e) ->
    $(e.currentTarget).toggleClass("accent")

  highlight2: (e) ->
    $(e.currentTarget).toggleClass("highlight")

  animateComponent: (e) ->
    if $('#syllabus').hasClass("editable")
      $(e.currentTarget).find('.toggle_grid').toggleClass("show_component_icon")
      $(e.currentTarget).find('.delete_component').toggleClass("show_component_icon")
      $(e.currentTarget).toggleClass("show_component_outline")

  deleteComponent: (e) ->
    is_new = $(e.currentTarget).closest(".component").hasClass("new")
    if not is_new
      component = @collection.get(parseInt($(e.currentTarget).parents().find(".component-title").attr("cid")))
    $(e.currentTarget).closest(".component").remove()
    if not is_new
      component.destroy()

  toggleGrid: (e) ->
    if $('#syllabus').hasClass("editable")
      for each in $(e.currentTarget).closest(".component").find("th")
        if $(each).hasClass("border_hidden")
          $(each).removeClass("border_hidden")
          $(each).addClass("border_visible")
        else
          $(each).removeClass("border_visible")
          $(each).addClass("border_hidden")
      for each in $(e.currentTarget).closest(".component").find("td")
        if $(each).hasClass("border_hidden")
          $(each).removeClass("border_hidden")
          $(each).addClass("border_visible")
        else
          $(each).removeClass("border_visible")
          $(each).addClass("border_hidden")
      component = @collection.get(parseInt($(e.currentTarget).closest(".component").find(".component-title").attr("cid")))
      attributes = "table_attributes"
      instance = component.get(attributes)
      if $(e.currentTarget).closest(".component").find("th").first().hasClass("border_visible")
        newClass = "border_visible"
      else
        newClass = "border_hidden"
      instance["border_class"] = newClass
      component.set(attributes, instance)
      component.save()

  openEditTab: ->
    hash = 
      sid: @model.get('id')
      uid: @model.get('user_id')
    
    view = new Syllabest.Views.Components.New(model: @model, collection: @collection)
    $('#edit_button').hide()
    syllabus_row = $('#syllabus_row').detach()
    $('#left_side').append(syllabus_row)
    $('#right_side').append(view.render().el)
    this.applyDrag()
    this.applySort()
    $('#syllabus').removeClass("expanded")
    if not @editMode
      $('#syllabus').addClass("shrunken")
      $('#edit_tab').addClass("slide")
    $('#syllabus').addClass("editable")
    @editMode = true
    this.makeComponentsEditable()

  makeComponentsEditable: ->
    for each in $(".component")
      title = $(each).find(".component-title").detach()
      $(each).find(".col-md-12").replaceWith("<div class='col-md-11 col-sm-11'></div>")
      $(each).find(".col-md-11").append(title)
      $(each).find(".col-md-11").after("<div class='col-md-1 col-sm-1 delete_col'></div>")
      is_table = $(each).find(".component-title").attr("component_type") is "table"
      if is_table
        grid_button = "<i class='fa fa-bars toggle_grid' title='Toggle grid'></i>"
        $(each).find(".delete_col").append($(grid_button))
      delete_button = "<i class='fa fa-remove delete_component' title='Delete this component'></i>"
      $(each).find(".delete_col").append($(delete_button))
      $(each).attr("title", "Drag to reorder, double-click to edit")

  cancelEdit: (e) ->
    $('#edit_tab').remove()
    $('#edit_button').show()
    syllabus_row = $('#syllabus_row').detach()
    $('.container-fluid').append(syllabus_row)
    $('#new_plaintext_button, #new_table_button, #new_calendar_buttion').draggable("disable")
    $('#components').sortable("disable")
    $('#syllabus').removeClass("editable")
    $('#syllabus').removeClass("shrunken")
    $('#syllabus').addClass("expanded")
    @editMode = false
    for each in $(".component")
      $(each).find(".delete_col").remove()
      title = $(each).find(".component-title").detach()
      $(each).find(".col-md-11").replaceWith("<div class='col-md-12 col-sm-12'></div>")
      $(each).find(".col-md-12").append(title)
      $(each).attr("title", "")
      if $(each).hasClass("new")
        $(each).remove()

  goToPDF: ->
    window.location.href = "pdf/syllabuses/#{@model.get('id')}.pdf"


