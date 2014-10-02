
schema = require('mongoose').Schema
mongoose = require('mongoose')

users = schema(
  email:
    type: String,
    required: true
  ,
  password:
    type: String,
    required: true
  ,
  name: String,
  surname: String,
  tel: String,
  street: String,
  locality: String
)


exports.usersSchema = users
exports.UsersModelo = mongoose.model('Users', users)