Syllabest.Views.Users ||= {}

class Syllabest.Views.Users.UserView extends Backbone.View
  template: JST["backbone/templates/users/user"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    #console.log 123
    @$el.html(@template(@model.toJSON() ))
    return this
