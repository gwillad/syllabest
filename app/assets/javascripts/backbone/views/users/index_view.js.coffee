class Syllabest.Views.Users.IndexView extends Backbone.View
  template: JST["backbone/templates/users/index"]

  events:
    'submit #new_user': 'createUser'
    'click #add_user': 'addUserForm'
    'click #cancel_form': 'removeUserForm'

  testAlert: ->
    alert "working!"

  initialize: ->
    _.bindAll(this, 'render')
#    this.listenTo(@collection, 'add', @appendUser)
#    this.listenTo(@collection, 'reset', @render)

    @collection.on('reset', @render, this)
    @collection.on('add',@appendUser,this)
    @collection.fetch()
    
  render: ->
    $(@el).html(@template())
    @collection.each @appendUser 
    this

  addUserForm: (event) ->
    event.preventDefault()
    view = new Syllabest.Views.Users.New
    $('#users').after(view.render().el)
    $('#users').hide()
    $('#add_user').hide()

  removeUserForm: (event) ->
    event.preventDefault()
    $('#warning-box').remove()
    $('#new_user').remove()
    $('#users').show()
    $('#add_user').show()

  appendUser: (user) ->
    view = new Syllabest.Views.User(model: user)
    $('#users').append(view.render().el)

  createUser: (event) ->
    event.preventDefault()
    attributes = 
      first_name: $('#new_user_fname').val()
      last_name:  $('#new_user_lname').val()
      email:      $('#new_user_email').val().toLowerCase()
      password:   $('#new_user_password').val()
      password_confirmation: $('#confirm_password').val()
      school:     $('#new_user_school').val()
      office:     $('#new_user_office').val()
    @collection.create attributes,
      wait: true
      success: ->
        $('#warning-box').remove()
        $('#new_user').remove()
        $('#add_user').show()
        $('#users').show()
      error: @handleError


  handleError: (user, response)->
    #console.log user
    #console.log response
    if response.status == 422
      $('#warning-box').remove()
      $('#warnings').append('<div id="warning-box" class="alert alert-danger"><a href="#" class="close" data-dismiss="alert">&times;</a><strong>Warning</strong> A problem has occured while submitting your data.</div>')
      $('#fname_errors').empty()
      $('#new_user_fname').removeClass('error')
      $('#fname_span').removeClass()

      $('#lname_errors').empty()
      $('#new_user_lname').removeClass('error')
      $('#lname_span').removeClass()

      $('#email_errors').empty()
      $('#new_user_email').removeClass('error')
      $('#email_span').removeClass()

      $('#password_errors').empty()
      $('#new_user_password').removeClass('error')
      $('#password_span').removeClass()

      $('#school_errors').empty()
      $('#new_user_school').removeClass('error')
      $('#school_span').removeClass()

      $('#office_errors').empty()
      $('#new_user_office').removeClass('error')
      $('#office_span').removeClass()


      errors = $.parseJSON(response.responseText).errors

      for attribute, messages of errors
        alert(attribute + ' ' +message) for message in messages
        if (attribute == "first_name")
          $('#fname_errors').empty()
          $('#fname_errors').text(' ('+messages+')')
          $('#fname_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_user_fname').addClass('error')
          $('#fname_span').css("color", "DarkRed")

        if (attribute == "email")
          #alert(messages.length)
          $('#email_errors').empty()
          $('#email_errors').text('('+messages+')')
          $('#email_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_user_email').addClass('error')
          $('#email_span').css("color", "DarkRed")

        if (attribute == "last_name")
          $('#lname_errors').empty()
          $('#lname_errors').text('('+messages+')')
          $('#lname_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_user_lname').addClass('error')
          $('#lname_span').css("color", "DarkRed")

        if (attribute == "password")
          $('#password_errors').empty()
          $('#password_errors').text('('+messages+')')
          $('#password_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_user_password').addClass('error')
          $('#password_span').css("color", "DarkRed")


        if (attribute == "office")
          $('#office_errors').empty()
          $('#office_errors').text('('+messages+')')
          $('#office_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_user_office').addClass('error')
          $('#office_span').css("color", "DarkRed")

        if (attribute == "school")
          $('#school_errors').empty()
          $('#school_errors').text('('+messages+')')
          $('#school_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_user_school').addClass('error')
          $('#school_span').css("color", "DarkRed")
          





#Old code
#$('#new_user_fname_label').append('<small class="text-danger"> ('+messages+')<small>')#('<p class="text-danger"><sub>' + message + '</sub></p') for message in messages

          #('#new_user_email').css({'border-color': 'red', 'box-shadow': '0 0 7px red'})

          #$('#new_user_fname').append('%span{:class=>"glyphicon glyphicon-remove form-control-feedback"}')
          #$('#new_user_fname').append('%i.fa.fa-times')
          #$('#new_user_fname').closest('.form-group').addClass('has-error')
