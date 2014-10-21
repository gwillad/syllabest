class Syllabest.Models.Syllabus extends Backbone.Model
  paramRoot: 'syllabus'

 

class Syllabest.Collections.SyllabusesCollection extends Backbone.Collection
  model: Syllabest.Models.Syllabus
  url: 'api/users/:id/syllabuses'