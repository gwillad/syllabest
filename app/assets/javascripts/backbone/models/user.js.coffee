class Syllabest.Models.User extends Backbone.Model
  paramRoot: 'user'

 

class Syllabest.Collections.UsersCollection extends Backbone.Collection
  model: Syllabest.Models.User
  url: '/api/users'

