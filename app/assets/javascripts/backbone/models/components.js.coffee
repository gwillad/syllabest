class Syllabest.Models.Component extends Backbone.Model
  paramRoot: 'syllabus'

 

class Syllabest.Collections.ComponentsCollection extends Backbone.Collection
  initialize: (models, options) ->
    @uid = options.uid
    @sid = options.sid

  model: Syllabest.Models.Component
  url: -> 
    '/api/users/'+ @uid + '/syllabuses/' + @sid + '/components'
 
    