class Syllabest.Views.Users.New extends Backbone.View
  template: JST["backbone/templates/users/new"]

  id: "sign_up"

  events:
    'click #submit_form': 'createUser'
    'click #cancel_form': 'cancelCreateUser'

  initialize:->
    #console.log 32

  render: ->
    @collection.fetch()
    #alert "Render"
    #console.log 42
    $(@el).html(@template())
    this

  cancelCreateUser: (event) ->
    event.preventDefault()
    $('#warning-box').remove()
    $('#sign_up').remove()
    window.location.href = "/"
    #window.location.replace("http://google.com")

  createUser: (event) ->
    #alert("Here")
    #console.log 45
    event.preventDefault()
    attributes = 
      first_name: $('#new_user_fname').val()
      last_name:  $('#new_user_lname').val()
      email:      $('#new_user_email').val().toLowerCase()
      password:   $('#new_user_password').val()
      password_confirmation: $('#confirm_password').val()
      school:     $('#new_user_school').val()
      office:     $('#new_user_office').val()
      phone:      $('#new_user_phone').val()
    @collection.create attributes,
      wait: true
      success: ->
        $('#warning-box').remove()
        window.location.href = "signin"
        #$('#sign_up').remove()
        #$('#add_user').show()
        #$('#users').show()
      error: @handleError


  handleError: (user, response)->
    #console.log user
    #console.log response.status
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
 
      $('#phone_errors').empty()
      $('#new_user_phone').removeClass('error')
      $('#phone_span').removeClass()

      $('#confirm_password_errors').empty()
      $('#confirm_password').removeClass('error')
      $('#confirm_password_span').removeClass()


      errors = $.parseJSON(response.responseText).errors
      #alert("Hello")
      for attribute, messages of errors
        #alert(attribute + ' ' +message) for message in messages
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

        if (attribute == "phone")
          $('#phone_errors').empty()
          $('#phone_errors').text('('+messages+')')
          $('#phone_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#new_user_phone').addClass('error')
          $('#phone_span').css("color", "DarkRed")
 
        if (attribute == "password_confirmation")
          $('#confirm_password_errors').empty()
          $('#confirm_password_errors').text('('+messages+')')
          $('#confirm_password_span').addClass('glyphicon glyphicon-remove form-control-feedback')
          $('#confirm_password').addClass('error')
          $('#confirm_password_span').css("color", "DarkRed")
          


