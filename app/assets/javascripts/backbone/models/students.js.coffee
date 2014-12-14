class Syllabest.Models.Student extends Backbone.Model
  paramRoot: 'student'

 

class Syllabest.Collections.StudentsCollection extends Backbone.Collection
  initialize: (models, options) ->
    @uid = options.uid
    @sid = options.sid

  model: Syllabest.Models.Student
  url: -> 
    '/api/users/'+ @uid + '/syllabuses/' + @sid + '/students'
 
    