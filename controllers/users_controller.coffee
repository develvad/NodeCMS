User = require("../models/User").UsersModelo

crypto = require('crypto')

_auth = (user, req, res) ->
  user.updated = Date.now()
  hash = crypto.createHash("md5")
  user.token = hash.update(JSON.stringify(user), "utf8").digest("hex")
  user.save((error) ->
    if not error
      req.session.user = user
      res.redirect('/panel')

      #res.render('panel/dashboard', {user:user})
      ###
      return res.send(
        status: 200
        user: _cleanupUser(user)
        #token: user.token
      )
      ###
    else
      console.log error
      return res.send(
        status: 400
        message: "User can't be authenticated"
      )
  )


# OPTIMIZE: return send error directly from here
_comparePass = (user, pass) ->
  hash = crypto.createHash("md5")
  if user.password
    if user.password isnt hash.update(pass, "utf8").digest("hex")
      return false
    return true

exports.panel = (req, res, next) ->
  res.render('panel/index', {user:req.session.user})


exports.isLoggedIn = (req, res, next) ->
  if req.session.user
    next()
  else
    res.redirect("/")

# Checking email and password params
exports.hasEmailPassword = (req, res, next) ->
  invalids = {}
  if not req.body.email or req.body.email is '' then invalids.email = 'email'
  if not req.body.password or req.body.password is '' then invalids.password = 'password'

  if invalids.email or invalids.password
    return res.send(
      status: 400
      invalids: invalids
      message: "missing fields"
    )
  else
    next()

# Checking if User exist by email in db
exports.userExists = (req, res, next) ->
  # Check if login with email or username
  User.findOne(email:req.body.email, (err, user) ->
    if err or not user
      return res.send(
        message: "El usuario no existe"
        status: 404
      )
  )
  next()

# Checking if user.password isn't req.body.password
exports.validEmailPassword = (req, res, next) ->
  User.findOne(email:req.body.email, (err, user) =>
    if user
      if not _comparePass(user, req.body.password)
        return res.send(
          message: "Password incorrecto"
          status: 401
        )
      else
        next()
  )



exports.auth = (req, res, next) ->
  User.findOne(email:req.body.email, (err, user) ->
    if user
      _auth(user, req, res)
  )


exports.perfil = (req, res, next) ->
  res.render('panel/index', user: req.session.user)

exports.editar = (req, res, next) ->
  User.findOne(_id: req.body._id, (err, user) ->
    if not err
      console.log req.body
      user.name = req.body.name
      user.surname = req.body.surname
      user.locality = req.body.locality
      user.street = req.body.street
      user.tel = req.body.tel
      user.save((err) ->
        if not err
          req.session.user = user
          res.redirect('/panel')
      )
  )

exports.logout = (req, res, next) ->
  if req.request and req.request.user then req.request.user = {} # remove session
  if req.session and req.session.user then req.session.user = {}
  res.redirect('/')

