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

  handleRoutingError: (id) ->	
    #console.log "error"
    #console.log #{id}
    Backbone.history.navigate("#users/#{id}", true)
 # if its a 403 redirect to the users own page
 # if its a 401 we want to redirect to signin

  userVisit: (id) ->	
    @collection =  new Syllabest.Collections.UsersCollection()
    @collection.fetch({async: false})
    @collection

  syllabiVisit: (hash, id) ->
    router = this
    syllabi =  new Syllabest.Collections.SyllabusesCollection([],hash)
    syllabi.fetch({wait: true,
    async: false,
    error:(collection, response, options)-> 
      Backbone.history.navigate("#users/#{JSON.parse(response["responseText"])["user"]}",true)})
    syllabi

  show: (id) ->
    @collection ?= @userVisit(id)
    hash = 
      id: id 
    #@syllabi = new Syllabest.Collections.SyllabusesCollection([],hash)
    syllabi = @syllabiVisit(hash, id)
    model = @collection.get(id)
    view = new Syllabest.Views.Users.ShowView(model: model, collection: syllabi)
    $('#container').html(view.render().el)
    #@syllabi.fetch({success: (syl) ->
     # view = new Syllabest.Views.Users.ShowView(model: model, collection: syl)
      #$('#container').html(view.render().el)
    #})

  showSyllabus: (userid, syllabusid) ->
    @collection ?= @userVisit(userid)
    @user = @collection.get(userid)
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
    view = new Syllabest.Views.Syllabuses.ShowView(model: @model, collection: @components, user: @user)
    $('#container').html(view.render().el)

  