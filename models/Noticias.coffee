schema = require('mongoose').Schema
mongoose = require('mongoose')

noticias = schema(
  titulo :
    type: String,
    required: true,
  descripcion :
    type: String,
    required: true,
  enlace: String,
  fecha:
      type: Date,
      default: Date.now
  ,
  owner_user: # usuario propietario de la noticia
    _id: String, # ID de user ...
    email: String,
    name: String,
    surname: String,
    tel: String,
    street: String,
    locality: String
)


exports.noticiasSchema = noticias
exports.NoticiasModelo = mongoose.model('Noticias', noticias)
