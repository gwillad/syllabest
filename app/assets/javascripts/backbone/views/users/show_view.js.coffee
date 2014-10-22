class Syllabest.Views.Users.ShowView extends Backbone.View
  template: JST["backbone/templates/users/show"]

  events:
    'submit #new_syllabus': 'createSyllabus'
    'click #add_syllabus': 'addSyllabusForm'
    'click #cancel_syllabus': 'removeSyllabusForm'

  initialize: -> 
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(user: @model))
    this

  addSyllabusForm: (event) ->
    event.preventDefault()
    view = new Syllabest.Views.Syllabuses.New
    $('#syllabi').after(view.render().el)
    $('#syllabi').hide()
    $('#add_syllabus').hide()

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
      department: $('#new_syllabus_title').val()
      term: $('#new_syllabus_term').val()
      section_num: $('#new_syllabus_section_num').val()
      course_type: $('#new_syllabus_course_type').val()
      user_id: @model.get("id")
    console.log attributes
    @collection.create attributes
    console.log @collection.toJSON()
    $('#new_syllabus').remove()
    $('#add_syllabus').show()
    $('#syllabi').show()
###

WHAT WE NEED TO DO:

add an add syllabus form and buttton to this view, need to make a subview and templates

make sure syllabus controller is working (permit)

start showing syllabi

start viewing syllabi

repeat above process for components, just no showing indiviudal components, but viewing them as a syllabus

make show syllabus look nice
###