class Syllabest.Routers.UsersRouter extends Backbone.Router
  routes:
    '': 'index'
    'users/:userid/syllabuses/:syllabusid': 'showSyllabus'
    'users/:id' : 'show'
    
  
  initialize: (options) ->
    @collection = new Syllabest.Collections.UsersCollection()
    @collection.fetch()

  index: ->
    view = new Syllabest.Views.Users.IndexView(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    hash = 
      id = id
    @syllabi = new Syllabest.Collections.SyllabusesCollection([],hash)
    @syllabi.fetch()
    @model = @collection.get(id)
    view = new Syllabest.Views.Users.ShowView(model: @model, collection: @syllabi)
    $('#container').html(view.render().el)

  showSyllabus: (userid, syllabusid) ->
    hash = 
      uid: userid
      sid: syllabusid
    #@components = new Syllabest.Collections.ComponentsCollection(uid, sid)
    #@components.fetch
    @model = @syllabi.get(syllabusid)
    view = new Syllabest.Views.Syllabuses.ShowView(model: @model)
    $('#container').html(view.render().el)
