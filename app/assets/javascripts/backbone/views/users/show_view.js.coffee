class Syllabest.Views.Users.ShowView extends Backbone.View
  template: JST["backbone/templates/users/show"]

  events:
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
    $('#container').after(view.render().el)
    $('#user_profile').hide()
    $('#add_syllabus').hide()

  removeSyllabusForm: (event) ->
    event.preventDefault()
    alert "22"
    #$('#new_syllabus').remove()

###

WHAT WE NEED TO DO:

add an add syllabus form and buttton to this view, need to make a subview and templates

make sure syllabus controller is working (permit)

start showing syllabi

start viewing syllabi

repeat above process for components, just no showing indiviudal components, but viewing them as a syllabus

make show syllabus look nice
###