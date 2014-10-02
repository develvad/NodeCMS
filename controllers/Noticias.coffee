NoticiaM = require("../models/Noticias").NoticiasModelo
User = require("../models/User").UsersModelo
_ = require('underscore')




exports.noticias = (req, res, next) ->
  NoticiaM.find({},(err, noticias) ->
    if not err
      console.log noticias
      # Return JSON
      # El cliente recibe "response"
      # response.title
      # response. status
      # response.noticias
      res.send(
        title: "pepe",
        status:200,
        noticias: noticias
      )
    else
      console.log err
  )


exports.leer10 = (req, res, next) ->
  NoticiaM.find({},{},{limit:10},(err, noticias) ->
    if not err
      console.log noticias
      res.render('index', {noticias: noticias})
    else
      console.log err
  )


exports.escribeloTodo = (req, res, next) ->
  ejemplo = new NoticiaM(
    titulo : "Titulo1",
    descripcion : "Descripcion1",
    enlace: "http://www.google.es",
    fecha: "2015-01-01"
  )

  ejemplo.save((err) ->
    res.render("index", title: "Vladi")
  )


exports.get = (req, res, next) ->
  NoticiaM.find({},(err, noticias) ->
    if not err
      console.log noticias
      res.render('panel/index', {noticias: noticias, user: req.session.user})
    else
      console.log err
  )

# Insert de noticia + propietario de la noticia
exports.post = (req, res, next) ->
  User.findOne(_id: req.body.user_id, (err, user) ->
    if not err
      console.log user
      noticia = new NoticiaM(
        titulo : req.body.titulo,
        descripcion : req.body.descripcion,
        enlace: req.body.enlace,
        fecha: Date.now(),
        #owner_user: _.pick(user, '_id', 'email' ,'name', 'surname', 'locality', 'street'); # inserta el usuario
        owner_user: _.omit(user, 'passowrd')
        # owner_user = user

      )
      noticia.save()
      res.redirect('/panel/index')
  )



  ## Sistemas de plantillas para user con backbone
  # mustache.js  Ej: {{ user.name }}
  # underscore.js # Yo uso este! Ej: <%= user.name %>



exports.newform = (req, res, next) ->
  res.render('panel/index', {user: req.session.user})