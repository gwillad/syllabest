class Syllabest.Views.Students.New extends Backbone.View
  template: JST["backbone/templates/students/new"]

  tagName: 'tr'
  className: 'newStudent'

  events: ->
    'click #destroy_student': 'destroyStudent'

  render: ->
    $(@el).html(@template())
    this

  destroyStudent: (e) ->
    $('#warning-box').remove()
    $(e.currentTarget).closest(".newStudent").remove()