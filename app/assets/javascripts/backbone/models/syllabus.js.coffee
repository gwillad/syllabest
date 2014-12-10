class Syllabest.Models.Syllabus extends Backbone.Model
  paramRoot: 'syllabus'

 

class Syllabest.Collections.SyllabusesCollection extends Backbone.Collection
  initialize: (models, options) ->
    @id = options.id

  model: Syllabest.Models.Syllabus
  url: -> 
    console.log "#{@id} is the id"
    '/api/users/'+ @id + '/syllabuses'