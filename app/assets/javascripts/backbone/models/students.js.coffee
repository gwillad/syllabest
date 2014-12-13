class Syllabest.Models.Studentt extends Backbone.Model
  paramRoot: 'component'

 

class Syllabest.Collections.StudentsCollection extends Backbone.Collection
  initialize: (models, options) ->
    @uid = options.uid
    @sid = options.sid

  model: Syllabest.Models.Component
  url: -> 
    '/api/users/'+ @uid + '/syllabuses/' + @sid + '/students'
 
    