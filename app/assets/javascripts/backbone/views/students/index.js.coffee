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

    @collection.create attributes,
      wait: true
      success: ->
        $('.newStudent').remove()
        $('#warning-box').remove()
        #alert("Success")
      error: @handleError


  handleError: (student, response)->
    #alert("Error!")
    #alert(response.status)

    if response.status == 422
      $('#warning-box').remove()
      $('#warnings').append('<div id="warning-box" class="alert alert-danger"><a href="#" class="close" data-dismiss="alert">&times;</a><strong>Warning</strong> The following errors have occured:<ul id="error_list"></ul></div>')

      $('#new_student_email').removeClass('error')
      $('#student_email_span').removeClass()

      $('#new_student_class_year').removeClass('error')
      $('#class_year_span').removeClass()

      errors = $.parseJSON(response.responseText).errors

      for attribute, messages of errors
        #alert(attribute + " " + message) for message in messages
        if (attribute == "email")
          #$('#email_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_student_email').addClass('error')
          $('#email_span').css("color", "DarkRed")
          $('#error_list').after('<li>'+message+'</li>') for message in messages

        if (attribute == "class_year")
          #$('#class_year_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_student_class_year').addClass('error')
          $('#class_year_span').css("color", "DarkRed")
          $('#error_list').after('<li>'+message+'</li>') for message in messages