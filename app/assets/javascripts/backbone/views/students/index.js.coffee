Syllabest.Views.Students ||= {}

class Syllabest.Views.Students.Index extends Backbone.View
  template: JST["backbone/templates/students/index"]

  id: "student_view"

  events: ->
    'click #new_student': 'createStudent'
    'click #add_student': 'addStudentForm'

  initialize: (options)->
    _.bindAll(this, 'render')
    @syllabus = options["syllabus"]
    @collection = new Syllabest.Collections.StudentsCollection([],{sid: @syllabus.get("id"), uid: @syllabus.get("user_id")})
    @collection.fetch({async:false})
    @collection.on('reset', @render, this)
    @collection.on('add',@appendStudent,this)
    @fetch = false

  render: ->
    if @fetch is false
      @collection.fetch()
      @fetch = true
    $(@el).html(@template())
    @collection.each @appendStudent
    this

  appendStudent: (student) ->

    view = new Syllabest.Views.Student(model: student)
    $('#students').append(view.render().el)

  addStudentForm: ->
    view = new Syllabest.Views.Students.New
    $('#students').append(view.render().el)

  createStudent: ->
    attributes = 
      first_name: $('#new_student_first_name').val()
      last_name: $('#new_student_last_name').val()
      class_year: $('#new_student_class_year').val()
      email: $('#new_student_email').val()

    @collection.create attributes
    $('.newStudent').remove()