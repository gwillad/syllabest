class Syllabest.Routers.UsersRouter extends Backbone.Router
  routes:
    '': 'index'
    'users/:id' : 'show'
  
  initialize: (options) ->
    @collection = new Syllabest.Collections.UsersCollection
    @collection.reset options.users

  index: ->
    view = new Syllabest.Views.Users.IndexView(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "User #{id}"

