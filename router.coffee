noticiasC = require './controllers/Noticias'
api_user = require './controllers/users_controller'

module.exports  = (app) ->

  app.get '/', noticiasC.leer10
  app.get '/vladi', noticiasC.escribeloTodo


  app.post "/login", api_user.hasEmailPassword, api_user.userExists, api_user.validEmailPassword, api_user.auth
  app.get "/logout", api_user.logout
  app.get "/panel", api_user.isLoggedIn, api_user.panel
  app.get "/panel/noticias", noticiasC.get
  app.get "/panel/noticias/new", noticiasC.newform
  app.post "/panel/noticias/new", noticiasC.post
  app.get "/panel/perfil", api_user.perfil
  app.post "/panel/perfil", api_user.editar


  # API noticias, retorna un JSON con todas las noticias para "jugar"
  # con Deferred y Promises en el cliente con Jquery
  app.get "/noticias", noticiasC.noticias

  # Retornando JSON para probar Backbone en el cliente
  app.get '/api/noticias', noticiasC.noticias
  ###
  app.post '/api/noticias', noticiasC.crearNoticia
  app.post '/api/noticias', noticiasC.actualizarNoticia
  app.delete '/api/noticias', noticiasC.eliminarNoticia
  ###