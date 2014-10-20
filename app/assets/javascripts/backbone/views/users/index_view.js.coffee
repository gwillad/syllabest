class Syllabest.Views.Users.IndexView extends Backbone.View
  template: JST["backbone/templates/users/index"]

  events:
    'submit #new_user': 'createUser'
    'click #add_user_form': 'addUserForm'
    'click #cancel_form': 'removeUserForm'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add',@appendUser,this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendUser)
    this

  addUserForm: (event) ->
    event.preventDefault()
    view = new Syllabest.Views.Users.New
    $('#users').after(view.render().el)
    $('#users').hide()
    $('#add_user_form').hide()

  removeUserForm: (event) ->
    event.preventDefault()
    $('#new_user').remove()
    $('#users').show()
    $('#add_user_form').show()

  appendUser: (user) ->
    view = new Syllabest.Views.User(model: user)
    $('#users').append(view.render().el)

  createUser: (event) ->
    event.preventDefault()
    attributes = 
      first_name: $('#new_user_fname').val()
      last_name:  $('#new_user_lname').val()
      email:      $('#new_user_email').val()
      password:   $('#new_user_password').val()
      school:     $('#new_user_school').val()
      office:     $('#new_user_office').val()
    @collection.create attributes
    $('#new_user').remove()
    $('#add_user_form').show()
    $('#users').show()

 
    
      

 
