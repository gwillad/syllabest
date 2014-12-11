class Syllabest.Views.Users.ShowView extends Backbone.View
  template: JST["backbone/templates/users/show"]

  events:
    'submit #new_syllabus': 'createSyllabus'
    'click #add_syllabus': 'addSyllabusForm'
    'click #cancel_syllabus': 'removeSyllabusForm'
    'click #back_button': 'returnToUsers'

  initialize: -> 
    _.bindAll(this, 'render')
    #this.listenTo(@collection, 'reset', @render)
    #this.listenTo(@collection, 'add', @appendSyllabus)
    @collection.on('reset', @render, this)
    @collection.on('add', @appendSyllabus, this)
    @collection.fetch()

  render: ->
    $(@el).html(@template(user: @model))
    @collection.each(@appendSyllabus)
    this

  addSyllabusForm: (event) ->
    event.preventDefault()
    view = new Syllabest.Views.Syllabuses.New
    $('#syllabi').after(view.render().el)
    $('#syllabi').hide()
    $('#add_syllabus').hide()

  appendSyllabus: (syllabus) ->
    view = new Syllabest.Views.Syllabus(model: syllabus)
    $('#syllabi').append(view.render().el)

  removeSyllabusForm: (event) ->
    event.preventDefault()
    $('#new_syllabus').remove()
    $('#syllabi').show()
    $('#add_syllabus').show()

  createSyllabus: (event) ->
    event.preventDefault()
    attributes = 
      title: $('#new_syllabus_title').val()
      location: $('#new_syllabus_location').val()
      course_num: $('#new_syllabus_course_num').val()
      department: $('#new_syllabus_department').val()
      term: $('#new_syllabus_term').val()
      section_num: $('#new_syllabus_section_num').val()
      course_type: $('#new_syllabus_course_type').val()
      user_id: @model.get("id")
      header_options: ["1", "0", "1", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
    ###
    # HEADER OPTIONS: [title, dept, course_num, course_type, 
    #                  school(user), term, location, first_name(user),
    #                  last_name(user), office(user), officehours, 
    #                  email(user), phone(user)] --> 13 <--
    ###
    @collection.create attributes
    $('#new_syllabus').remove()
    $('#add_syllabus').show()
    $('#syllabi').show()

  returnToUsers: ->
    Backbone.history.navigate("", true)

###

WHAT WE NEED TO DO:

add an add syllabus form and buttton to this view, need to make a subview and templates

make sure syllabus controller is working (permit)

start showing syllabi

start viewing syllabi

repeat above process for components, just no showing indiviudal components, but viewing them as a syllabus

make show syllabus look nice
###