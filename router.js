// Generated by CoffeeScript 1.6.2
var api_user, noticiasC;

noticiasC = require('./controllers/Noticias');

api_user = require('./controllers/users_controller');

module.exports = function(app) {
  app.get('/', noticiasC.leer10);
  app.get('/vladi', noticiasC.escribeloTodo);
  app.post("/login", api_user.hasEmailPassword, api_user.userExists, api_user.validEmailPassword, api_user.auth);
  app.get("/logout", api_user.logout);
  app.get("/panel", api_user.isLoggedIn, api_user.panel);
  app.get("/panel/noticias", noticiasC.get);
  app.get("/panel/noticias/new", noticiasC.newform);
  app.post("/panel/noticias/new", noticiasC.post);
  app.get("/panel/perfil", api_user.perfil);
  app.post("/panel/perfil", api_user.editar);
  app.get("/noticias", noticiasC.noticias);
  return app.get('/api/noticias', noticiasC.noticias);
  /*
  app.post '/api/noticias', noticiasC.crearNoticia
  app.post '/api/noticias', noticiasC.actualizarNoticia
  app.delete '/api/noticias', noticiasC.eliminarNoticia
  */

};
