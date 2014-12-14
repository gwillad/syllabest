class Syllabest.Views.Users.ShowView extends Backbone.View
  template: JST["backbone/templates/users/show"]

  events:
    'submit #new_syllabus': 'createSyllabus' #this might just be a precaution
    'click #submit_syllabus': 'createSyllabus'
    'click #add_syllabus': 'addSyllabusForm'
    'click #cancel_syllabus': 'removeSyllabusForm'
    #'click #back_button': 'returnToUsers'
    'hover #back_button, #destroy_syllabus': 'highlight'
    'click #logout': 'logout_user'

  initialize: -> 
    _.bindAll(this, 'render')
    #this.listenTo(@collection, 'reset', @render)
    #this.listenTo(@collection, 'add', @appendSyllabus)
    @collection.on('reset', @render, this)
    @collection.on('add', @appendSyllabus, this)
    @test = false
    

  render: ->
    if @test is false
      @collection.fetch()
      @test = true
    $(@el).html(@template(user: @model))
    @collection.each(@appendSyllabus)
    this

  highlight: (e) ->
    $(e.currentTarget).toggleClass("accent")

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
    $('#warning-box').remove()
    $('#new_syllabus_view').remove()
    $('#syllabi').show()
    $('#add_syllabus').show()

  createSyllabus: (event) ->
    event.preventDefault()

    office_hours = []
    office_hours.push [$('#new_syllabus_office_hrs_su_start').val(), $('#new_syllabus_office_hrs_su_end').val()]
    office_hours.push [$('#new_syllabus_office_hrs_mo_start').val(), $('#new_syllabus_office_hrs_mo_end').val()]
    office_hours.push [$('#new_syllabus_office_hrs_tu_start').val(), $('#new_syllabus_office_hrs_tu_end').val()]
    office_hours.push [$('#new_syllabus_office_hrs_we_start').val(), $('#new_syllabus_office_hrs_we_end').val()]
    office_hours.push [$('#new_syllabus_office_hrs_th_start').val(), $('#new_syllabus_office_hrs_th_end').val()]
    office_hours.push [$('#new_syllabus_office_hrs_fr_start').val(), $('#new_syllabus_office_hrs_fr_end').val()]
    office_hours.push [$('#new_syllabus_office_hrs_sa_start').val(), $('#new_syllabus_office_hrs_sa_end').val()]

    attributes = 
      title: $('#new_syllabus_title').val()
      location: $('#new_syllabus_location').val()
      course_num: $('#new_syllabus_course_num').val()
      department: $('#new_syllabus_department').val()
      term: $('#new_syllabus_term').val()
      section_num: $('#new_syllabus_section_num').val()
      course_type: $('#new_syllabus_course_type').val()
      office_hrs: office_hours
      user_id: @model.get("id")
      header_options: ["1", "1", "0", "0", "0", "0", "0", "0", "0", "0"]
    ###
    # HEADER OPTIONS: [title, dept + course_num + course_type, 
    #                  school(user), term, location, first_name(user),
    #                  + last_name(user), office(user), officehours, 
    #                  email(user), phone(user)] --> 10 <--
    ###
    @collection.create attributes,
      wait: true
      success: ->
        $('#new_syllabus').remove()
        $('#add_syllabus').show()
        $('#syllabi').show()
        @collection.fetch()
      error: @handleError

  returnToUsers: ->
    Backbone.history.navigate("/users", true)

  logout_user: (event) ->
    event.preventDefault()
    $.ajax({url:"/signout",type:"DELETE",success: (response, b, c)->
      window.location.href = "/signin"})

  handleError: (syllabus, response) ->
    if response.status == 422
      $('#warning-box').remove()
      $('#warnings').append('<div id="warning-box" class="alert alert-danger"><a href="#" class="close" data-dismiss="alert">&times;</a><strong>Warning</strong> A problem has occured while submitting your data.</div>')
      
      $('#title_errors').empty()
      $('#new_syllabus_title').removeClass('error')
      $('#title_span').removeClass()

      $('#department_errors').empty()
      $('#new_syllabus_department').removeClass('error')
      $('#department_span').removeClass()

      $('#course_num_errors').empty()
      $('#new_syllabus_course_num').removeClass('error')
      $('#course_num_span').removeClass()

      $('#section_num_errors').empty()
      $('#new_syllabus_section_num').removeClass('error')
      $('#section_num_span').removeClass()

      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        if (attribute == "title")
          $('#title_errors').empty()
          $('#title_errors').text('('+messages+')')
          $('#title_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_syllabus_title').addClass('error')
          $('#title_span').css("color", "DarkRed")

        if (attribute == "department")
          $('#department_errors').empty()
          $('#department_errors').text('('+messages+')')
          $('#department_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_syllabus_department').addClass('error')
          $('#department_span').css("color", "DarkRed")

        if (attribute == "course_num")
          $('#course_num_errors').empty()
          $('#course_num_errors').text('('+messages+')')
          $('#course_num_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_syllabus_course_num').addClass('error')
          $('#course_num_span').css("color", "DarkRed")

        if (attribute == "section_num")
          $('#section_num_errors').empty()
          $('#section_num_errors').text('('+messages+')')
          $('#section_num_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_syllabus_section_num').addClass('error')
          $('#section_num_span').css("color", "DarkRed")

