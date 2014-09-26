class Syllabest.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    first_name: null
    last_name: null
    email: null
    password: null
    school: null
    office: null

class Syllabest.Collections.UsersCollection extends Backbone.Collection
  model: Syllabest.Models.User
  url: '/users'
