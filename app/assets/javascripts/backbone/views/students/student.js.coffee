class Syllabest.Views.Student extends Backbone.View
  template: JST["backbone/templates/students/student"]

  tagName: 'tr'
  className: 'student'

  events: 
    'click #destroy_student': 'destroyStudent'

  render: ->
    $(@el).html(@template(student: @model))
    this

  destroyStudent: (e) ->
    $(e.currentTarget).closest(".student").remove()
    @model.destroy()