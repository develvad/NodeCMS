// Generated by CoffeeScript 1.6.2
var User, crypto, _auth, _comparePass;

User = require("../models/User").UsersModelo;

crypto = require('crypto');

_auth = function(user, req, res) {
  var hash;

  user.updated = Date.now();
  hash = crypto.createHash("md5");
  user.token = hash.update(JSON.stringify(user), "utf8").digest("hex");
  return user.save(function(error) {
    if (!error) {
      req.session.user = user;
      return res.redirect('/panel');
      /*
      return res.send(
        status: 200
        user: _cleanupUser(user)
        #token: user.token
      )
      */

    } else {
      console.log(error);
      return res.send({
        status: 400,
        message: "User can't be authenticated"
      });
    }
  });
};

_comparePass = function(user, pass) {
  var hash;

  hash = crypto.createHash("md5");
  if (user.password) {
    if (user.password !== hash.update(pass, "utf8").digest("hex")) {
      return false;
    }
    return true;
  }
};

exports.panel = function(req, res, next) {
  return res.render('panel/index', {
    user: req.session.user
  });
};

exports.isLoggedIn = function(req, res, next) {
  if (req.session.user) {
    return next();
  } else {
    return res.redirect("/");
  }
};

exports.hasEmailPassword = function(req, res, next) {
  var invalids;

  invalids = {};
  if (!req.body.email || req.body.email === '') {
    invalids.email = 'email';
  }
  if (!req.body.password || req.body.password === '') {
    invalids.password = 'password';
  }
  if (invalids.email || invalids.password) {
    return res.send({
      status: 400,
      invalids: invalids,
      message: "missing fields"
    });
  } else {
    return next();
  }
};

exports.userExists = function(req, res, next) {
  User.findOne({
    email: req.body.email
  }, function(err, user) {
    if (err || !user) {
      return res.send({
        message: "El usuario no existe",
        status: 404
      });
    }
  });
  return next();
};

exports.validEmailPassword = function(req, res, next) {
  var _this = this;

  return User.findOne({
    email: req.body.email
  }, function(err, user) {
    if (user) {
      if (!_comparePass(user, req.body.password)) {
        return res.send({
          message: "Password incorrecto",
          status: 401
        });
      } else {
        return next();
      }
    }
  });
};

exports.auth = function(req, res, next) {
  return User.findOne({
    email: req.body.email
  }, function(err, user) {
    if (user) {
      return _auth(user, req, res);
    }
  });
};

exports.perfil = function(req, res, next) {
  return res.render('panel/index', {
    user: req.session.user
  });
};

exports.editar = function(req, res, next) {
  return User.findOne({
    _id: req.body._id
  }, function(err, user) {
    if (!err) {
      console.log(req.body);
      user.name = req.body.name;
      user.surname = req.body.surname;
      user.locality = req.body.locality;
      user.street = req.body.street;
      user.tel = req.body.tel;
      return user.save(function(err) {
        if (!err) {
          req.session.user = user;
          return res.redirect('/panel');
        }
      });
    }
  });
};

exports.logout = function(req, res, next) {
  if (req.request && req.request.user) {
    req.request.user = {};
  }
  if (req.session && req.session.user) {
    req.session.user = {};
  }
  return res.redirect('/');
};
