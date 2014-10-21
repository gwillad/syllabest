class Syllabest.Routers.UsersRouter extends Backbone.Router
  routes:
    '': 'index'
    'users/:id' : 'show'
  
  initialize: (options) ->
    @collection = new Syllabest.Collections.UsersCollection()
    @collection.fetch()

  index: ->
    view = new Syllabest.Views.Users.IndexView(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    @syllabi = new Syllabest.Collections.SyllabusesCollection()
    @model = @collection.get(id)
    view = new Syllabest.Views.Users.ShowView(model: @model, collection: @syllabi)
    $('#container').html(view.render().el)

