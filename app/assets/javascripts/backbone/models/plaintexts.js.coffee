class Syllabest.Models.Plaintext extends Backbone.Model
  paramRoot: 'plaintext'

 

class Syllabest.Collections.PlaintextsCollection extends Backbone.Collection
  initialize: (models, options) ->
    @uid = options.uid
    @sid = options.sid
    @cid = options.cid

  model: Syllabest.Models.Plaintext
  url: -> 
    '/api/users/'+ @uid + '/syllabuses/' + @sid + '/components' + @cid + '/plaintexts'