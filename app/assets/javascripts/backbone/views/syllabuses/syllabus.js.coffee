class Syllabest.Views.Syllabus extends Backbone.View
  template: JST["backbone/templates/syllabuses/syllabus"]

  tagName: 'tr'

  events:
    'click #view_syllabus': 'showSyllabus'
    'click #destroy_syllabus':'destroySyllabus'

  showSyllabus: ->
  	Backbone.history.navigate("users/#{@model.get('user_id')}/syllabuses/#{@model.get('id')}", true)

  destroySyllabus: (e) ->
    $(e.currentTarget).closest('tr').remove()
    @model.destroy()

  render: ->
    $(@el).attr("syllabus-id", @model["id"])
    $(@el).html(@template(syllabus: @model))
    this