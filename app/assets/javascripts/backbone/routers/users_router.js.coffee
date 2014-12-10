Syllabest.Views.Users ||= {}

class Syllabest.Routers.UsersRouter extends Backbone.Router
  routes:
    #'': 'reroute'
    '': 'index'
    'users/:userid/syllabuses/:syllabusid': 'showSyllabus'
    'users/:id' : 'show'
  
  #reroute: ->
    #Backbone.history.navigate("users", {trigger: true})
    #this

  splash: ->
    $('#container').html(JST["backbone/templates/splash"]())

  index: ->
    @collection = new Syllabest.Collections.UsersCollection()
    @collection.fetch({success: (col) -> 
      view = new Syllabest.Views.Users.IndexView(collection: col)
      $('#container').html(view.render().el)
   })

  userVisit: (id) ->	
    @collection ?=  new Syllabest.Collections.UsersCollection()
    @collection.fetch({async: false})
    @collection

  syllabiVisit: (hash) ->
    @syllabi ?=  new Syllabest.Collections.SyllabusesCollection([],hash)
    @syllabi.fetch({async: false})
    @syllabi

  show: (id) ->
    @collection ?= @userVisit(id)
    hash = 
      id: id 
    @syllabi = new Syllabest.Collections.SyllabusesCollection([],hash)
 #   console.log @collection
    model = @collection.get(id)
#    console.log model    
    @syllabi.fetch({success: (syl) ->
      view = new Syllabest.Views.Users.ShowView(model: model, collection: syl)
      $('#container').html(view.render().el)
    })

  showSyllabus: (userid, syllabusid) ->
    hash = 
      id: userid
    @syllabi ?= @syllabiVisit(hash)
    # @syllabi.fetch({async: false})
    hash = 
      uid: userid
      sid: syllabusid
    @components = new Syllabest.Collections.ComponentsCollection([],hash)
    @model = @syllabi.get(syllabusid)
    @components.fetch()
    view = new Syllabest.Views.Syllabuses.ShowView(model: @model, collection: @components)
    $('#container').html(view.render().el)